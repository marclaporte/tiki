<?php
class TikiWebdav_Backends_File extends ezcWebdavSimpleBackend implements ezcWebdavLockBackend
{
	private $requestMimeType;

	protected $options;
	protected $root;
	protected $lockLevel = 0;

	protected $handledLiveProperties = array( 
		'getcontentlength', 
		'getlastmodified', 
		'creationdate', 
		'displayname', 
		'getetag', 
		'getcontenttype', 
		'resourcetype',
//		'supportedlock',
//		'lockdiscovery',
	);

	protected $propertyStorage = null;
	
	public function getRoot() {
		return $this->root;
	}

	public function __construct()
	{
		global $prefs;

		// avoid not having a deadlock when trying to acquire WebDav lock
		//@file_put_contents('/tmp/tiki4log', "Lock Directory: ".$prefs['fgal_use_dir']."\n", FILE_APPEND );
		if ( !empty($prefs['fgal_use_dir']) && file_exists($prefs['fgal_use_dir'] ) ) {
			$this->root = realpath( $prefs['fgal_use_dir'] );
		} else {
			$this->root = realpath( 'temp/' );
		}
		$this->options = new ezcWebdavFileBackendOptions( array ( 'lockFileName' => $this->root.'/.webdav_lock', 'waitForLock' => 200000, 'propertyStoragePath' => $this->root, 'noLock' => false ) ); 
		$this->propertyStorage = new ezcWebdavBasicPropertyStorage();
	}

	public function lock( $waitTime, $timeout )
	{
///		@file_put_contents('/tmp/tiki4log', "WARNING: lock method not implemented\n", FILE_APPEND );

		// Check and raise lockLevel counter
		//@file_put_contents('/tmp/tiki4log', "LOCK Level: ".$this->lockLevel." \n", FILE_APPEND );
		if ( $this->lockLevel > 0 )
		{
			// Lock already acquired
			++$this->lockLevel;
			return;
		}

		$lockStart = microtime( true );

		// Timeout is in microseconds...
		$timeout /= 1000000;
		$lockFileName = $this->options->lockFileName;
		//@file_put_contents('/tmp/tiki4log', "LOCK: ".$this->options->lockFileName." \n", FILE_APPEND );

		// fopen in mode 'x' will only open the file, if it does not exist yet.
		// Even this is is expected it will throw a warning, if the file
		// exists, which we need to silence using the @
		if ( !empty($this->options->lockFileName) ) {
			if ( file_exists($lockFileName) ) {
				while ( file_exists($lockFileName) )
				{
					// This is untestable.
						//@file_put_contents('/tmp/tiki4log', "LOCK TIME ".(microtime( true ) - $lockStart).":".$timeout." \n", FILE_APPEND );
					if ( microtime( true ) - $lockStart > $timeout )
					{
						// Release timed out lock
						unlink( $lockFileName );
						//@file_put_contents('/tmp/tiki4log', "LOCK TIMEOUT ".(microtime( true ) - $lockStart).":".$timeout." \n", FILE_APPEND );
						$lockStart = microtime( true );
					}
					else
					{
						usleep( $waitTime );
					}
				}
			}
			@file_put_contents($lockFileName, microtime(),FILE_APPEND );
		}

		// Add first lock
		++$this->lockLevel;
		//@file_put_contents('/tmp/tiki4log', "LOCK END \n", FILE_APPEND );
	}

	public function unlock()
	{
		//@file_put_contents('/tmp/tiki4log', "unLOCK Level: ".$this->lockLevel." \n", FILE_APPEND );
		if ( --$this->lockLevel === 0 )
		{
			// Remove the lock file
			$lockFileName = $this->options->lockFileName;
			if ( !empty($this->options->lockFileName) ) {
				unlink( $lockFileName );
			}
			//@file_put_contents('/tmp/tiki4log', "Remove LOCK: ".$this->options->lockFileName." \n", FILE_APPEND );
		}
	}

	public function __get( $name )
	{
		switch ( $name )
		{
			case 'options':
				return $this->$name;

			default:
				throw new ezcBasePropertyNotFoundException( $name );
		}
	}

	public function __set( $name, $value )
	{
		switch ( $name )
		{
			case 'options':
				if ( ! $value instanceof ezcWebdavMemoryBackendOptions ) ///FIXME
				{
					throw new ezcBaseValueException( $name, $value, 'ezcWebdavMemoryBackendOptions' ); ///FIXME
				}

				$this->$name = $value;
				break;

			default:
				throw new ezcBasePropertyNotFoundException( $name );
		}
	}

	protected function acquireLock( $readOnly = false )
	{
		if ( empty($this->options->lockFileName) )
		{
			return true;
		}

		try
		{
			//@file_put_contents('/tmp/tiki4log', "LOCK: \n", FILE_APPEND );
			$this->lock( $this->options->waitForLock, 2000000 );
		}
		catch ( ezcWebdavLockTimeoutException $e )
		{
			//@file_put_contents('/tmp/tiki4log', "LOCK: failed\n", FILE_APPEND );
			return false;
		}
		//@file_put_contents('/tmp/tiki4log', "LOCK: Acquired\n", FILE_APPEND );
		return true;
	}

	protected function freeLock()
	{
		//@file_put_contents('/tmp/tiki4log', "FreeLOCK: ".$this->options->lockFileName."\n", FILE_APPEND );
		if ( empty($this->options->lockFileName) )
		{
			//@file_put_contents('/tmp/tiki4log', "FreeLOCK: TOTO\n", FILE_APPEND );
			return true;
		}

		$this->unlock();
	}

	protected function getMimeType( $path, $filename = '' )
	{
		// Check if extension pecl/fileinfo is usable.
		if ( $this->options->useMimeExts && ezcBaseFeatures::hasExtensionSupport( 'fileinfo' ) )
		{
			$fInfo = new fInfo( FILEINFO_MIME );
			$mimeType = $fInfo->file( $this->root . $path );

			// The documentation tells to do this, but it does not work with a
			// current version of pecl/fileinfo
			// $fInfo->close();

			return $mimeType;
		}

		// Check if extension ext/mime-magic is usable.
		if ( $this->options->useMimeExts && 
			ezcBaseFeatures::hasExtensionSupport( 'mime_magic' ) &&
			( $mimeType = mime_content_type( $this->root . $path ) ) !== false )
		{
			return $mimeType;
		}

		// Check if some browser submitted mime type is available.
/* FIXME
		$storage = $this->getPropertyStorage( $path );
		$properties = $storage->getAllProperties();

		if ( isset( $properties['DAV:']['getcontenttype'] ) )
		{
			return $properties['DAV:']['getcontenttype']->mime;
		}
*/
		// Try to detect mimetype from the file extension
		if ( ! empty( $filename ) && ( $pos = strrpos( $filename, '.' ) ) !== false )
		{
			include_once ("lib/mime/mimetypes.php");

			$ext = substr( $filename, $pos + 1 );

			if ( ! empty( $mimetypes[$ext] ) )
			{
				return $mimetypes[$ext];
			}
		}

                if (isset($mimetypes[$ext])) {
                        return $mimetypes[$ext];
                } else {
                        return $defaultmime;
                }

		// Default to 'application/octet-stream' if no mimetype has been detected
		return 'application/octet-stream';
	}

	protected function createCollection( $path )
	{
		global $user, $tikilib;
		global $filegallib; require_once('lib/filegals/filegallib.php');

		if ( empty( $path ) )
			return false;

		if ( substr( $path, -1, 1 ) === '/' ) $path = substr( $path, 0, -1 );

		if ( ( $objectId = $filegallib->get_objectid_from_virtual_path( dirname( $path ) ) ) === false || $objectId['type'] != 'filegal' )
			return false;

		// Get parent filegal info as a base
		$filegalInfo = $filegallib->get_file_gallery_info($objectId['id']);

		$filegalInfo['galleryId'] = -1;
		$filegalInfo['parentId'] = $objectId['id'];
		$filegalInfo['name'] = basename( $path );
		$filegalInfo['description'] = '';
		$filegalInfo['user'] = $user;

		return (bool) $filegallib->replace_file_gallery($filegalInfo);
	}

	protected function createResource( $path, $content = null )
	{
		global $user, $tikilib, $prefs;
		global $filegallib; require_once('lib/filegals/filegallib.php');

		//@file_put_contents('/tmp/tiki4log', "createResource: $path, content=$content \n", FILE_APPEND );
		if ( empty($path)
			|| substr($path, -1, 1) == '/'
			|| ( $objectId = $filegallib->get_objectid_from_virtual_path( dirname( $path ) ) ) === false
			|| $objectId['type'] != 'filegal'
		) return false;

		$name = basename( $path );
		if ( empty($content) ) $content = '';

		if ( $prefs['fgal_use_db'] === 'n' ) {
			$fhash = md5( $name );
			do
			{
				$fhash = md5( uniqid( $fhash ) );
			}
			while ( file_exists( $this->root . '/' . $fhash ) );

			if ( @file_put_contents( $this->root . '/' . $fhash, $content ) === false )
				return false;
		} else {
			$fhash = '';
		}

///		$type = empty($this->requestMimeType) ? '' : $this->requestMimeType;

		//@file_put_contents('/tmp/tiki4log', print_r(debug_backtrace(false),true), FILE_APPEND );
			//@file_put_contents('/tmp/tiki4log', 'galleryId:'.$objectId['id']."name=$name,filename=$name,content=$content,user=$user,fhash=$fhash\n", FILE_APPEND );

		$fileId = $filegallib->insert_file(
			$objectId['id'],
			$name,
			'',
			$name,
			'',
			0,
			'application/octet-stream',
			$user,
			$fhash,
			'',
			$user
		);
		//@file_put_contents('/tmp/tiki4log', "createResource: end fileID=$fileId\n", FILE_APPEND );	
		return $fileId != 0;
	}

	protected function setResourceContents( $path, $content )
	{
		global $user, $tikilib, $prefs;
		global $filegallib; require_once('lib/filegals/filegallib.php');

		if ( empty($path)
			|| substr($path, -1, 1) == '/'
			|| ( $objectId = $filegallib->get_objectid_from_virtual_path( $path ) ) === false
			|| $objectId['type'] != 'file'
		) return false;

		$name = basename( $path );
		if ( empty($content) ) $content = '';

		if ( $prefs['fgal_use_db'] === 'n' ) {
			$fhash = md5( $name );
			do
			{
				$fhash = md5( uniqid( $fhash ) );
			}
			while ( file_exists( $this->root . '/' . $fhash ) );
		} else {
			$fhash = '';
		}

		//@file_put_contents('/tmp/tiki4log', "setResourceContents : $path/$fhash \n", FILE_APPEND );
		$fileInfo = $filegallib->get_file_info($objectId['id'], false, false);
		$filegalInfo = $filegallib->get_file_gallery_info($fileInfo['galleryId']);

		if ( $prefs['fgal_use_db'] === 'n' && empty($fileInfo['path']) && @file_put_contents( $this->root . '/' . $fhash, $content ) === false ) {
			return false;
		}

		$fileId = $filegallib->replace_file(
			$objectId['id'],
			$fileInfo['name'],
			$fileInfo['description'],
			$fileInfo['filename'],
			$content,
			@strlen( $content ),
///			empty($this->requestMimeType) ? $fileInfo['filetype'] : $this->requestMimeType,
			$this->getMimeType( '/' . $fhash, $name ),
			$user,
			$fhash,
			'',
			$filegalInfo,
			true
		);
		//@file_put_contents('/tmp/tiki4log', "setResourceContents: fileId = $fileId end \n", FILE_APPEND );	
		return $fileId;
	}

	protected function getResourceContents( $path )
	{
		global $tikilib;
		global $filegallib; require_once('lib/filegals/filegallib.php');

		$result = false;
		$objectId = $filegallib->get_objectid_from_virtual_path( $path );

		if ( $objectId !== false && $objectId['type'] == 'file' )
		{
			$fileInfo = $tikilib->get_file($objectId['id']);
			if ( empty($fileInfo['path']) ) {
				return $fileInfo['data'];
			} else {
				$result = $this->root . '/' . $fileInfo['path'];

				if ( ! file_exists($result) )
					return false;
			}
			return file_get_contents( $result );
		}
	}

	///TODO
	protected function getPropertyStorage( $path )
	{
		//@file_put_contents('/tmp/tiki4log', "getPropertyStorage method \n", FILE_APPEND );
		if ( @file_exists($storagePath = $this->options->propertyStoragePath.'/properties-'.md5($path)) ) {
			//$xml = DOMDocument::load($storagePath);
			$xml = ezcWebdavServer::getInstance()->xmlTool->createDom( @file_get_contents($storagePath) );
			//@file_put_contents('/tmp/tiki4log', "getPropertyStorage content XML=".file_get_contents($storagePath)."\n", FILE_APPEND );
		} else {
			$xml = ezcWebdavServer::getInstance()->xmlTool->createDom();
		}
		$handler = new ezcWebdavPropertyHandler(
        new ezcWebdavXmlTool()
        );
		//@file_put_contents('/tmp/tiki4log', "getPropertyStorage method TOTO 1 XML=".serialize($xml)."\n", FILE_APPEND );
		try {
		$handler->extractProperties($xml->getElementsByTagNameNS('DAV:','*'),$this->propertyStorage);
		}
		catch ( Exception $e ) {
			//@file_put_contents('/tmp/tiki4log', "getPropertyStorage method TOTO 3 ".$e->getMessage()."\n", FILE_APPEND );
		}
		//@file_put_contents('/tmp/tiki4log', "getPropertyStorage method TOTO 2\n", FILE_APPEND );

		//@file_put_contents('/tmp/tiki4log', "All properties:".print_r($this->propertyStorage->getAllProperties(),true)."\n", FILE_APPEND );
		//@file_put_contents('/tmp/tiki4log', "getPropertyStorage method end\n", FILE_APPEND );
		return $this->propertyStorage;
	}

	protected function storeProperties( $path, ezcWebdavBasicPropertyStorage $storage )
	{
		//@file_put_contents('/tmp/tiki4log', "storeProperties method \n", FILE_APPEND );
		$storagePath = $this->options->propertyStoragePath.'/properties-'.md5($path);

		//@file_put_contents('/tmp/tiki4log', "storeProperties method TOTO1 $storagePath\n", FILE_APPEND );
		// Create handler structure to read properties
		$handler = new ezcWebdavPropertyHandler(
				$xml = new ezcWebdavXmlTool()
				);

		//@file_put_contents('/tmp/tiki4log', "storeProperties method TOTO2\n", FILE_APPEND );
		// Create new dom document with property storage for one namespace
		$doc = new DOMDocument( '1.0' );

		$properties = $doc->createElement( 'properties' );
		$doc->appendChild( $properties );

		//@file_put_contents('/tmp/tiki4log', "storeProperties method TOTO3\n", FILE_APPEND );
		// Store and store properties
		foreach ($this->handledLiveProperties as $propName) {
			$storage->detach($propName);
		}
		$handler->serializeProperties(
				$storage,
				$properties
				);

		//@file_put_contents('/tmp/tiki4log', "storeProperties method end\n", FILE_APPEND );
		
		return $doc->save( $storagePath );
	}

	///TODO
	public function setProperty( $path, ezcWebdavProperty $property )
	{
		//@file_put_contents('/tmp/tiki4log', "setProperty method PATH=$path PROPERTY:".$property->name."\n", FILE_APPEND );
		// Check if property is a self handled live property and return an
		// error in this case.
		if ( ( $property->namespace === 'DAV:' ) &&
				in_array( $property->name, $this->handledLiveProperties, true ) &&
				( $property->name !== 'getcontenttype' ) &&
				( $property->name !== 'lockdiscovery' ) )
		{
			return false;
		}

		// Get namespace property storage
		$storage = $this->getPropertyStorage( $path );

		// Attach property to store
		$storage->attach( $property );

		// Store document back
		$this->storeProperties( $path, $storage );
		//@file_put_contents('/tmp/tiki4log', "setProperty method PATH=$path PROPERTY:".$property->name." value=".print_r($this->getProperty($path,$property->name,true))."\n", FILE_APPEND );

		return true;
	}

	public function removeProperty( $path, ezcWebdavProperty $property )
	{
		//@file_put_contents('/tmp/tiki4log', "WARNING: removeProperty method not implemented\n", FILE_APPEND );
		// Live properties may not be removed.
		if ( $property instanceof ezcWebdavLiveProperty )
		{
			return false;
		}

		// Get namespace property storage
		$storage = $this->getPropertyStorage( $path );

		// Attach property to store
		$storage->detach( $property->name, $property->namespace );

		// Store document back
		$this->storeProperties( $path, $storage );

		return true;
		return true; ///FIXME
	}

	///TODO
	public function resetProperties( $path, ezcWebdavPropertyStorage $storage )
	{
		//@file_put_contents('/tmp/tiki4log', "WARNING: resetProperties method not implemented\n", FILE_APPEND );
		$this->storeProperties( $path, $storage );
		return true; ///FIXME
	}

	public function getProperty( $path, $propertyName, $namespace = 'DAV:' )
	{
		global $tikilib;
		global $filegallib; include_once('lib/filegals/filegallib.php');

		//@file_put_contents('/tmp/tiki4log', "GetProperty($path, $propertyName, $namespace)", FILE_APPEND );
		if ( ( $objectId = $filegallib->get_objectid_from_virtual_path($path) ) === false ) {
			//@file_put_contents('/tmp/tiki4log', "GetProperty out early\n", FILE_APPEND); 
				return false;
		}

		$isCollection = ( $objectId['type'] == 'filegal' );

		//@file_put_contents('/tmp/tiki4log', "GetProperty $path isCollection".($isCollection ?' TRUE':'FALSE')."\n", FILE_APPEND);
		if ( $isCollection ) {
			$tikiInfo = $filegallib->get_file_gallery_info($objectId['id']);
		} else {
			$tikiInfo = $filegallib->get_file_info($objectId['id']);
		}

		//@file_put_contents('/tmp/tiki4log', "GetProperty TikiInfo".print_r($tikiInfo,true)."\n", FILE_APPEND);

		$storage = $this->getPropertyStorage( $path );

		$properties = $storage->getAllProperties();
		//@file_put_contents('/tmp/tiki4log', "GetProperty TOTO $path\n", FILE_APPEND); 
		// Handle dead propreties
		if ( $namespace !== 'DAV:' )
		{
			return $properties[$namespace][$propertyName];
			//@file_put_contents('/tmp/tiki4log', "GetProperty out early 2\n", FILE_APPEND); 
		}

		// Handle live properties
		switch ( $propertyName )
		{
			case 'getcontentlength':
				$property = new ezcWebdavGetContentLengthProperty(
					$isCollection ?
					ezcWebdavGetContentLengthProperty::COLLECTION :
					$tikiInfo['filesize']
				);
				//@file_put_contents('/tmp/tiki4log', "-> " . ($isCollection ?  ezcWebdavGetContentLengthProperty::COLLECTION :$tikiInfo['filesize']) ."\n", FILE_APPEND );
				return $property;

			case 'getlastmodified':
				$property = new ezcWebdavGetLastModifiedProperty( new ezcWebdavDateTime(
					'@' . (int)$tikiInfo['lastModif']
				) );
				//@file_put_contents('/tmp/tiki4log', "-> " . $tikiInfo['lastModif'] ."\n", FILE_APPEND );
				return $property;

			case 'creationdate':
				$property = new ezcWebdavCreationDateProperty( new ezcWebdavDateTime(
					'@' . (int)$tikiInfo['created']
				) );
				//@file_put_contents('/tmp/tiki4log', "-> " . $tikiInfo['created'] ."\n", FILE_APPEND );
				return $property;

			case 'displayname':
				$property = new ezcWebdavDisplayNameProperty(
					$tikiInfo['name']
				);
				//@file_put_contents('/tmp/tiki4log', "-> " . $tikiInfo['name'] ."\n", FILE_APPEND );
				return $property;

			case 'getcontenttype':
				$property = new ezcWebdavGetContentTypeProperty(
					$isCollection ?
					'httpd/unix-directory' :
					( empty($tikiInfo['filetype']) ? 'application/octet-stream' : $tikiInfo['filetype'] )
				);
				//@file_put_contents('/tmp/tiki4log', "-> " . ( $isCollection ?  'httpd/unix-directory' : ( empty($tikiInfo['filetype']) ? 'application/octet-stream' : $tikiInfo['filetype'] ) ) ."\n", FILE_APPEND );
				return $property;

			case 'getetag':
				$md5 = ( $isCollection || empty($tikiInfo['hash']) ) ? md5($path) : $tikiInfo['hash'];
				$property = new ezcWebdavGetEtagProperty(
					'"' . $md5 . '-' . crc32($md5) . '"'
				);
				//@file_put_contents('/tmp/tiki4log', "-> " . '"' . $md5 . '-' . crc32($md5) . '"' ."\n", FILE_APPEND );
				return $property;

			case 'resourcetype':
				$property = new ezcWebdavResourceTypeProperty(
					$isCollection ?
					ezcWebdavResourceTypeProperty::TYPE_COLLECTION :
					ezcWebdavResourceTypeProperty::TYPE_RESOURCE
				);
				//@file_put_contents('/tmp/tiki4log', "-> " . ( $isCollection ? 'TYPE_COLLECTION' : 'TYPE_RESOURCE' ) ."\n", FILE_APPEND );
				return $property;

			case 'supportedlock':
				if ( !isset($properties[$namespace][$propertyName]) ) {
					$property = new ezcWebdavLockDiscoveryProperty();
				} else {
					$property = $properties[$namespace][$propertyName];
				}
				//@file_put_contents('/tmp/tiki4log', "-> " . print_r($property, true) . "\n", FILE_APPEND );
				return $property;

			case 'lockdiscovery':
				if ( !isset($properties[$namespace][$propertyName]) ) {
					$property = new ezcWebdavLockDiscoveryProperty();
				} else {
					$property = $properties[$namespace][$propertyName];
				}
				//@file_put_contents('/tmp/tiki4log', "-> " . print_r($property, true) . "\n", FILE_APPEND );
				return $property;

			default:
				// Handle all other live properties like dead properties
				$properties = $storage->getAllProperties();
				return $properties[$namespace][$propertyName];
		}
	}

	private function getContentLength( $path )
	{
		//@file_put_contents('/tmp/tiki4log', "getContentLength $path". $this->getProperty( $path, 'getcontentlength' )->contentlength ."\n", FILE_APPEND);
		return $this->getProperty( $path, 'getcontentlength' )->contentlength;
	}

	protected function getETag( $path )
	{
		if ( $etag = $this->getProperty( $path, 'getetag' ) ) {
			return $this->getProperty( $path, 'getetag' )->etag;
		} else {
			return md5($path);
		}
	}

	public function getAllProperties( $path )
	{
		$storage = $this->getPropertyStorage( $path );

		// Add all live properties to stored properties
		foreach ( $this->handledLiveProperties as $property )
		{
			//@file_put_contents('/tmp/tiki4log', "getAllProperties : property : $property\n", FILE_APPEND );
			$storage->attach( $this->getProperty( $path, $property ) );
		}

		return $storage;
	}

	///TODO
	public function copyRecursive( $source, $destination, $depth = ezcWebdavRequest::DEPTH_INFINITY )
	{
		//@file_put_contents('/tmp/tiki4log', "WARNING: copyRecursive method not implemented\n", FILE_APPEND );
		return true; ///FIXME
	}

	///TODO
	protected function performCopy( $fromPath, $toPath, $depth = ezcWebdavRequest::DEPTH_INFINITY )
	{
		//@file_put_contents('/tmp/tiki4log', "WARNING: performCopy method not implemented\n", FILE_APPEND );
		return true; ///FIXME
	}

	protected function performDelete( $path )
	{
		global $filegallib; include_once('lib/filegals/filegallib.php');

		if ( ( $objectId = $filegallib->get_objectid_from_virtual_path($path) ) === false )
			return false;

		switch ( $objectId['type'] )
		{
			case 'file': return (bool) $filegallib->remove_file( $filegallib->get_file($objectId['id']) );
			case 'filegal': return (bool) $filegallib->remove_file_gallery($objectId['id']);
		}

		return false;
	}

	protected function nodeExists( $path )
	{
		global $filegallib; include_once('lib/filegals/filegallib.php');
		return $filegallib->get_objectid_from_virtual_path($path) !== false;
	}

	protected function isCollection( $path )
	{
		global $filegallib; include_once('lib/filegals/filegallib.php');
		return ( $objectId = $filegallib->get_objectid_from_virtual_path($path) ) !== false && $objectId['type'] == 'filegal';
	}

	protected function getCollectionMembers( $path ) {
		global $tikilib;
		global $filegallib; include_once('lib/filegals/filegallib.php');

		$contents = array();
		$errors = array();


		$galleryId = ( $objectId = $filegallib->get_objectid_from_virtual_path($path) ) !== false ? $objectId['id'] : false;

		//@file_put_contents('/tmp/tiki4log', "-> getCollectionMembers\n", FILE_APPEND );
		//@file_put_contents('/tmp/tiki4log', "-> getCollectionMembers\ngalleryId:$galleryId\n", FILE_APPEND );
		if ( $galleryId !== false ) {
			//$files = $tikilib->get_files(0, -1, 'name_desc', '', (int)$galleryId, false, true, false, true, false, false, false, false, 'admin', true, false);
			$files = $tikilib->get_files(0, -1, 'name_desc', '', (int)$galleryId, true, true, false, true, false, false, false, false, 'admin', true, false);

			foreach ( $files['data'] as $fileInfo ) {
				if ( $fileInfo['isgal'] == '1' ) {
					// Add collection without any children
					$contents[] = new ezcWebdavCollection( $path . $fileInfo['name'] . '/' );
				} else {
					// Add files without content
					//$contents[] = new ezcWebdavResource( $path . $fileInfo['name'] . ( $fileInfo['nbArchives'] > 0 ? "?".$fileInfo['nbArchives'] : '') );
					$contents[] = new ezcWebdavResource( $path . $fileInfo['name'] );
				}
			}
		}

		//@file_put_contents('/tmp/tiki4log',"getCollectionMembers ".print_r($contents,true). "\n", FILE_APPEND );
		return $contents;
	}

	public function get( ezcWebdavGetRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: GET --\n", FILE_APPEND );
		//$this->acquireLock( true );
		$return = parent::get( $request );
		//$this->freeLock();

		return $return;
	}

	public function head( ezcWebdavHeadRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: HEAD --\n", FILE_APPEND );
		//$this->acquireLock( true );
		$return = parent::head( $request );
		//$this->freeLock();

		return $return;
	}

	public function propFind( ezcWebdavPropFindRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: PROPFIND --\n", FILE_APPEND );
//		$this->acquireLock( true );
		$return = parent::propFind( $request );
//		$this->freeLock();

		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: PROPFIND end --\n", FILE_APPEND );
		return $return;
	}

	public function propPatch( ezcWebdavPropPatchRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: PROPPATCH --\n", FILE_APPEND );
		$this->acquireLock();
		$return = parent::propPatch( $request );
		$this->freeLock();

		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: PROPPATCH end --\n", FILE_APPEND );
		return $return;
	}

	public function put( ezcWebdavPutRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: PUT --\n", FILE_APPEND );
///		$this->requestMimeType = $request->getHeader('Content-Type');
		$this->acquireLock();
		$return = parent::put( $request );
		$this->freeLock();

		//@file_put_contents('/tmp/tiki4log', "\n-- HTTP method: PUT end --\n", FILE_APPEND );
		return $return;
	}

	public function delete( ezcWebdavDeleteRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: DELETE --".print_r($request,true)."\n", FILE_APPEND );
		$this->acquireLock();
		$return = parent::delete( $request );
		$this->freeLock();

		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: DELETE end --".print_r($request,true)."\n", FILE_APPEND );
		return $return;
	}

	public function copy( ezcWebdavCopyRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: COPY --\n", FILE_APPEND );
		$this->acquireLock();
		$return = parent::copy( $request );
		$this->freeLock();

		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: COPY end --\n", FILE_APPEND );
		return $return;
	}

	public function move( ezcWebdavMoveRequest $request )
	{
		global $tikilib, $prefs;
		global $filegallib; include_once('lib/filegals/filegallib.php');

		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: MOVE --\n", FILE_APPEND );

		$this->acquireLock();

		// Indicates wheather a destiantion resource has been replaced or not.
		// The success response code depends on this.
		$replaced = false;

		// Extract paths from request
		$source = $request->requestUri;
		$dest = $request->getHeader( 'Destination' );

		// Check authorization
		// Need to do this before checking of node existence is checked, to
		// avoid leaking information 
/*
		///FIXME: Can't call this private method...
		$authState = $this->recursiveAuthCheck(
			$request,
			$dest,
			ezcWebdavAuthorizer::ACCESS_WRITE,
			true
		);

		if ( count( $authState['errors'] ) !== 0 )
		{
			// Source permission denied
			return $authState['errors'][0];
		}
*/
		if ( !ezcWebdavServer::getInstance()->isAuthorized( $dest, $request->getHeader( 'Authorization' ), ezcWebdavAuthorizer::ACCESS_WRITE ) )
		{
			$this->freeLock();
			return $this->createUnauthorizedResponse(
				$dest,
				$request->getHeader( 'Authorization' )
			);
		}

		// Check if resource is available
		if ( !$this->nodeExists( $source ) )
		{
			$this->freeLock();
			return new ezcWebdavErrorResponse(
				ezcWebdavResponse::STATUS_404,
				$source
			);
		}

		// If source and destination are equal, the request should always fail.
		if ( $source === $dest )
		{
			$this->freeLock();
			return new ezcWebdavErrorResponse(
				ezcWebdavResponse::STATUS_403,
				$source
			);
		}

		// Check if destination resource exists and throw error, when
		// overwrite header is F
		if ( ( $request->getHeader( 'Overwrite' ) === 'F' ) &&
			$this->nodeExists( $dest ) )
		{
			$this->freeLock();
			return new ezcWebdavErrorResponse(
				ezcWebdavResponse::STATUS_412,
				$dest
			);
		}

		// Check if the destination parent directory already exists, otherwise
		// bail out.
		if ( !$this->nodeExists( $destDir = dirname( $dest ) ) )
		{
			$this->freeLock();
			return new ezcWebdavErrorResponse(
				ezcWebdavResponse::STATUS_409,
				$dest
			);
		}

		// Verify If-[None-]Match headers on the $source
/*
		///FIXME: Can't call this private method...
		$res = $this->checkIfMatchHeadersRecursive(
			$request,
			$source,
			// We move, not copy!
			ezcWebdavRequest::DEPTH_INFINITY
		);
		if ( $res !== null )
		{
			return $res;
		}
*/

		// Verify If-[None-]Match headers on the $dest if it exists
		if ( $this->nodeExists( $dest ) &&
			( $res = $this->checkIfMatchHeaders( $request, $dest ) ) !== null
		)
		{
			$this->freeLock();
			return $res;
		}
		// Verify If-[None-]Match headers on the on $dests parent dir, if it
		// does not exist
		elseif ( ( $res = $this->checkIfMatchHeaders( $request, $destDir ) ) !== null )
		{
			$this->freeLock();
			return $res;
		}

		// The destination resource should be deleted if it exists and the
		// overwrite headers is T
		if ( ( $request->getHeader( 'Overwrite' ) === 'T' ) &&
			$this->nodeExists( $dest ) )
		{
			// Check sub-sequent authorization on destination
			$authState = $this->recursiveAuthCheck(
				$request,
				$dest,
				ezcWebdavAuthorizer::ACCESS_WRITE,
				true
			);
			if ( count( $authState['errors'] ) !== 0 )
			{
				// Permission denied on deleting destination
				$this->freeLock();
				return $authState['errors'][0];
			}

			$replaced = true;

			if ( count( $delteErrors = $this->performDelete( $dest ) ) > 0 )
			{
				$this->freeLock();
				return new ezcWebdavMultistatusResponse( $delteErrors );
			}
		}

		// All checks are passed, we can actually move now.

		$infos = array();
		$doRename = false;
		$doMove = false;

		foreach ( array( 'source', 'dest' ) as $k )
		{
			// Get source and dest infos
			if ( ( $infos[$k] = $filegallib->get_objectid_from_virtual_path( $$k ) ) !== false )
			{
				switch ( $infos[$k]['type'] )
				{
					case 'filegal':
						$infos[$k]['infos'] = $filegallib->get_file_gallery_info( $infos[$k]['id'] );
						$infos[$k]['parentId'] = $infos[$k]['infos']['parentId'];
						$infos[$k]['name'] = $infos[$k]['infos']['name'];
						break;
	
					case 'file':
						///TODO: Throw an error if dest is a file, but source is a filegal

						$infos[$k]['infos'] = $tikilib->get_file( $infos[$k]['id'] );
						$infos[$k]['parentId'] = $infos[$k]['infos']['galleryId'];
						$infos[$k]['name'] = $infos[$k]['infos']['filename'];
						break;
				}
			}
			// If dest doesn't exist, it usually means that the file / filegal has to be renamed
			elseif ( $k == 'dest' )
			{
				///TODO: Throw an error if dest is a new filegal, but source is a file

				if ( ( $objectId = $filegallib->get_objectid_from_virtual_path( dirname( $$k ) ) ) !== false
					&& $objectId['type'] == 'filegal'
				)
				{
					$infos[$k] = array(
						'id' => $infos['source']['id'],
						'type' => $infos['source']['type'],
						'infos' => $infos['source']['infos'],
						'parentId' => $objectId['id'],
						'name' => basename( $$k )
					);

					switch ( $infos[$k]['type'] )
					{
						case 'filegal':
							$infos[$k]['infos']['name'] = $infos[$k]['name'];
							$infos[$k]['infos']['parentId'] = $infos[$k]['parentId'];
							break;

						case 'file':
							$infos[$k]['infos']['name'] = $infos[$k]['name'];
							$infos[$k]['infos']['filename'] = $infos[$k]['name'];
							$infos[$k]['infos']['galleryId'] = $infos[$k]['parentId'];
							break;
					}

					$doRename = true;
				}
			}
			// If source doesn't exist, we stop here
			else
			{
				break;
			}
		}

		$doMove = $infos['source']['parentId'] != $infos['dest']['parentId'];
		$noErrors = true;

		switch ( $infos['source']['type'] )
		{
			case 'filegal':

				if ( $doRename )
				{
					$noErrors = (bool) $filegallib->replace_file_gallery(
						$infos['dest']['infos']
					);
				}
				// Move is not needed if the rename occured, since filegal renaming function handle the move already
				elseif ( $doMove )
				{
					$noErrors = (bool) $filegallib->move_file_gallery(
						$infos['source']['id'],
						$infos['dest']['parentId']
					);
				}

				break;

			case 'file':

				if ( $doRename )
				{
					/*
					$noErrors = (bool) $filegallib->update_file(
						$infos['source']['id'],
						$infos['dest']['name'],
						$infos['source']['infos']['description'],
						$user,
						$infos['source']['infos']['comment'],
						false
					);
					*/

					if ( $prefs['fgal_use_db'] === 'n' ) {
						$newPath = md5( $infos['dest']['name'] );
						do
						{
							$newPath = md5( uniqid( $newPath ) );
						}
						while ( file_exists( $this->root . '/' . $newPath ) );

						if ( ( @rename( $this->root . '/' . $infos['source']['infos']['path'] , $this->root . '/' . $newPath ) === false )
								|| ( @file_put_contents( $this->root . '/' . $infos['source']['infos']['path'], '' ) === false )
							 )
						{
							$this->freeLock();
							return false;
						}
					} else {
						$newPath = '';
					}

					$noErrors = (bool) $filegallib->replace_file(
						$infos['source']['id'],
						$infos['dest']['name'],
						$infos['source']['infos']['description'],
						$infos['dest']['name'],
						$infos['source']['infos']['data'],
						$infos['source']['infos']['filesize'],
						$infos['source']['infos']['filetype'],
						$user,
						$newPath,
						'',
						$filegallib->get_file_gallery_info( $infos['source']['parentId'] ),
						true,
						$infos['source']['infos']['author'],
						$infos['source']['infos']['created'],
						$infos['source']['infos']['lockedby']
					);
				}

				if ( $doMove && $noErrors )
				{
					$noErrors = (bool) $filegallib->set_file_gallery(
						$infos['source']['id'],
						$infos['dest']['parentId']
					);
				}

				break;
		}
		$this->freeLock();

		// Send proper response on success
		if ( $noErrors )
		{
			$return = new ezcWebdavMoveResponse(
				$replaced
			);
		}
		else
		{
			$return = new ezcWebdavErrorResponse(
				ezcWebdavResponse::STATUS_500
			);
		}


		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: MOVE end --\n", FILE_APPEND );
		return $return;
	}

	public function makeCollection( ezcWebdavMakeCollectionRequest $request )
	{
		//@file_put_contents('/tmp/tiki4log', "-- HTTP method: MAKECOL --\n", FILE_APPEND );
		$this->acquireLock();
		$return = parent::makeCollection( $request );
		$this->freeLock();

		return $return;
	}
}
