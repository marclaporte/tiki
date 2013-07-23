<?php

class Tiki_Profile_List
{
	function getSources() // {{{
	{
		global $prefs;
		$raw = explode( "\n", $prefs['profile_sources'] );
		$raw = array_map( 'trim', $raw );
		$sources = array();
		foreach( $raw as $source )
			if( !empty( $source ) )
			{
				$file = $this->getCacheLocation( $source );
				$last = $this->getCacheLastUpdate( $source );
				$short = dirname($source);
				$sources[] = array(
					'url' => $source,
					'domain' => (0===strpos($short,'http://')) ? substr($short, 7) : $short,
					'short' => $short,
					'status' => ($last && filesize($file)) ? 'open' : 'closed',
					'lastupdate' => $last,
					'formatted' => $last ? date( 'Y-m-d H:i:s', $last ) : '' );
			}

		return $sources;
	} // }}}

	function refreshCache( $path ) // {{{
	{
		$file = $this->getCacheLocation( $path );

		// Replace existing with blank file
		if( file_exists( $file ) )
			unlink($file);
		touch($file);

		$content = TikiLib::httprequest( $path );

		$parts = explode( "\n", $content );
		$parts = array_map( 'trim', $parts );
		$good = false;

		foreach( $parts as $line )
		{
			// All lines contain 3 entries
			if( empty( $line ) )
				continue;
			if( substr_count( $line, "\t" ) != 2 )
				return false;

			$good = true;
		}

		// A valid file has at least one profile
		if( !$good )
			return false;

		file_put_contents( $file, $content . "\n" );

		return true;
	} // }}}

	function getCategoryList( $source = '' ) // {{{
	{
		$category_list = array();
	
		$sources = $this->getSources();

		foreach( $sources as $s )
		{
			if( $source && $s['url'] != $source )
                                continue;
				
			if( !$s['lastupdate'] )
                                continue;

                        $fp = fopen( $this->getCacheLocation( $s['url'] ), 'r' );

                        while( false !== $row = fgetcsv( $fp, 200, "\t" ) )
                        {
				list( $c, $t, $i ) = $row;
				if ($c) $category_list[] = $c;
			}
		}

		natsort( $category_list );	
		return( array_unique( $category_list ) );
	} // }}}
							
	function getList( $source = '', $category = '', $profile = '' ) // {{{
	{
		$installer = new Tiki_Profile_Installer;
		$list = array();

		$sources = $this->getSources();

		foreach( $sources as $s )
		{
			if( $source && $s['url'] != $source )
				continue;

			if( !$s['lastupdate'] )
				continue;

			$fp = fopen( $this->getCacheLocation( $s['url'] ), 'r' );

			while( false !== $row = fgetcsv( $fp, 200, "\t" ) )
			{
				if( count($row) != 3 )
					continue;

				list( $c, $t, $i ) = $row;

				$key = "{$s['url']}#{$i}";

				if( $category && stripos( $c, $category ) === false )
					continue;
				if( $profile && stripos( $i, $profile ) === false )
					continue;

				if( array_key_exists( $key, $list ) )
				{
					$list[$key]['category'] .= ", $c";
				}
				else
				{
					$list[$key] = array(
						'domain' => $s['domain'],
						'category' => $c,
						'name' => $i,
						'installed' => $installer->isKeyInstalled( $s['domain'], $i ),
					);
				}
			}

			fclose($fp);
		}

		return array_values( $list );
	} // }}}

	private function getCacheLocation( $path ) // {{{
	{
		$hash = md5($path);
		return "temp/cache/profile$hash";
	} // }}}

	private function getCacheLastUpdate( $path ) // {{{
	{
		$file = $this->getCacheLocation( $path );
		if( ! file_exists( $file ) )
			return 0;
		
		return filemtime( $file );
	} // }}}
}