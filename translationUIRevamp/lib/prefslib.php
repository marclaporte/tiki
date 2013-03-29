<?php

class PreferencesLib
{
	private $data = array();

	function getPreference( $name, $deps = true, $source = null ) {
		global $prefs;
		static $id = 0;
		$data = $this->loadData( $name );

		if( isset( $data[$name] ) ) {
			$info = $data[$name];

			if( $source == null ) {
				$source = $prefs;
			}
		
			$value = $source[$name];
			if( false !== $unserialized = unserialize( $value ) ) {
				$value = $unserialized;
			}

			$info['preference'] = $name;
			if( isset( $info['serialize'] ) ) {
				$fnc = $info['serialize'];
				$info['value'] = $fnc( $value );
			} else {
				$info['value'] = $value;
			}
			$info['raw'] = $source[$name];
			$info['id'] = 'pref-' . ++$id;
			if( isset( $info['help'] ) && $prefs['feature_help'] == 'y' ) {
				
				if ( preg_match('/^https?:/i', $info['help']) ) 
				// If help is an url, return it without adding $helpurl 
					$info['helpurl'] = $info['help'];
				else
					$info['helpurl'] = $prefs['helpurl'] . $info['help'];
			}
			if( $deps && isset( $info['dependencies'] ) ) {
				$info['dependencies'] = $this->getDependencies( $info['dependencies'] );
			}

			$info['available'] = true;

			if( isset( $info['extensions'] ) ) {
				$info['available'] = $this->checkExtensions( $info['extensions'] );
			}

			return $info;
		}

		return false;
	}

	private function checkExtensions( $extensions ) {
		$installed = get_loaded_extensions();

		foreach( $extensions as $ext ) {
			if( ! in_array( $ext, $installed ) ) {
				return false;
			}
		}

		return true;
	}

	function getMatchingPreferences( $criteria ) {
		$index = $this->getIndex();

		$results = $index->find( $criteria );

		$prefs = array();
		foreach( $results as $hit ) {
			$prefs[] = $hit->preference;
		}

		return $prefs;
	}

	function applyChanges( $handled, $data, $limitation = null ) {
		global $tikilib, $user_overrider_prefs;

		if( is_array( $limitation ) ) {
			$handled = array_intersect( $handled, $limitation );
		}

		$changes = array();
		foreach( $handled as $pref ) {
			$info = $this->getPreference( $pref );
			$function = '_get' . ucfirst( $info['type'] ) . 'Value';
			$value = $this->$function( $info, $data );

			if( in_array($pref, $user_overrider_prefs) || $tikilib->get_preference( $pref ) != $value ) {
				$tikilib->set_preference( $pref, $value );
				$changes[$pref] = $value;
			}
		}

		return $changes;
	}

	function getInput( JitFilter $filter, $preferences = array(), $environment ) {
		$out = array();

		foreach( $preferences as $name ) {
			$info = $this->getPreference( $name );

			if( $environment == 'perspective' && isset( $info['perspective'] ) && $info['perspective'] === false ) {
				continue;
			}
			
			if( isset( $info['filter'] ) ) {
				$filter->replaceFilter( $name, $info['filter'] );
			}

			if( isset( $info['separator'] ) ) {
				$out[ $name ] = $filter->asArray( $name, $info['separator'] );
			} else {
				$out[ $name ] = $filter[$name];
			}
		}

		return $out;
	}

	private function loadData( $name ) {
		if( false !== $pos = strpos( $name, '_' ) ) {
			$file = substr( $name, 0, $pos );
		} else {
			$file = 'global';
		}

		return $this->getFileData( $file );
	}

	private function getFileData( $file ) {
		if( ! isset( $this->files[$file] ) ) {
			require_once 'lib/prefs/' . $file . '.php';
			$function = "prefs_{$file}_list";
			if( function_exists( $function ) ) {
				$this->files[$file] = $function();
			} else {
				$this->files[$file] = array();
			}
		}

		return $this->files[$file];
	}

	private function getDependencies( $dependencies ) {
		$out = array();

		foreach( $dependencies as $dep ) {
			if( $info = $this->getPreference( $dep, false ) ) {
				$out[] = array(
					'name' => $dep,
					'label' => $info['name'],
					'type' => $info['type'],
					'link' => 'tiki-admin.php?lm_criteria=' . urlencode($info['name']),
					'met' =>
						( $info['type'] == 'flag' && $info['value'] == 'y' )
						|| ( $info['type'] != 'flag' && ! empty( $info['value'] ) )
				);
			}
		}

		return $out;
	}

	private function getIndex() {
		global $prefs;
		if( $prefs['language'] == 'en' ) {
			require_once 'StandardAnalyzer/Analyzer/Standard/English.php';
			Zend_Search_Lucene_Analysis_Analyzer::setDefault(
				new StandardAnalyzer_Analyzer_Standard_English() );
		}

		$file = 'temp/cache/preference-index-' . $prefs['language'];

		require_once 'Zend/Search/Lucene.php';
		if( ! file_exists( $file ) ) {
			$index = Zend_Search_Lucene::create( $file );

			foreach( glob( 'lib/prefs/*.php' ) as $file ) {
				$file = substr( basename( $file ), 0, -4 );
				$data = $this->getFileData( $file );

				foreach( $data as $pref => $info ) {
					$doc = $this->indexPreference( $pref, $info );
					$index->addDocument( $doc );
				}
			}

			$index->optimize();
			return $index;
		}

		return Zend_Search_Lucene::open( $file );
	}

	private function indexPreference( $pref, $info ) {
		$doc = new Zend_Search_Lucene_Document();
		$doc->addField( Zend_Search_Lucene_Field::UnIndexed('preference', $pref) );
		$doc->addField( Zend_Search_Lucene_Field::Text('name', $info['name']) );
		$doc->addField( Zend_Search_Lucene_Field::Text('description', $info['description']) );

		if( isset( $info['options'] ) ) {
			$doc->addField( Zend_Search_Lucene_Field::Text('options', implode( ' ', $info['options'] ) ) );
		}

		return $doc;
	}

	private function _getFlagValue( $info, $data ) {
		$name = $info['preference'];

		return isset( $data[$name] ) ? 'y' : 'n';
	}

	private function _getTextValue( $info, $data ) {
		$name = $info['preference'];

		if( isset($info['separator']) ) {
			$value = explode( $info['separator'], $data[$name] );
		} else {
			$value = $data[$name];
		}

		if( isset($info['filter']) && $filter = TikiFilter::get( $info['filter'] ) ) {
			if( is_array( $value ) ) {
				return array_map( array( $filter, 'filter' ), $value );
			} else {
				return $filter->filter( $value );
			}
		} else {
			return $value;
		}
	}

	private function _getPasswordValue( $info, $data ) {
		$name = $info['preference'];

		if( isset($info['filter']) && $filter = TikiFilter::get( $info['filter'] ) ) {
			return $filter->filter( $data[$name] );
		} else {
			return $data[$name];
		}
	}

	private function _getTextareaValue( $info, $data ) {
		$name = $info['preference'];

		if( isset($info['filter']) && $filter = TikiFilter::get( $info['filter'] ) ) {
			$value = $filter->filter( $data[$name] );
		} else {
			$value = $data[$name];
		}

		if( isset( $info['unserialize'] ) ) {
			$fnc = $info['unserialize'];

			return $fnc( $value );
		} else {
			return $value;
		}
	}

	private function _getListValue( $info, $data ) {
		$name = $info['preference'];
		$value = $data[$name];

		$options = $info['options'];

		if( isset( $options[$value] ) ) {
			return $value;
		} else {
			return reset( array_keys( $options ) );
		}
	}

	private function _getMultilistValue( $info, $data ) {
		$name = $info['preference'];
		$value = (array) $data[$name];

		$options = $info['options'];
		$options = array_keys( $options );

		return array_intersect( $value, $options );
	}
	private function _getRadioValue( $info, $data ) {
		$name = $info['preference'];
		$value = $data[$name];

		$options = $info['options'];
		$options = array_keys( $options );

		if (in_array($value, $options)) {
			return $value;
		} else {
			return '';
		}
	}

	private function _getMulticheckboxValue( $info, $data ) {
		return $this->_getMultilistValue( $info, $data );
	}
}

global $prefslib;
$prefslib = new PreferencesLib;