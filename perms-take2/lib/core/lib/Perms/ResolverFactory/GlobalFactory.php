<?php

class Perms_ResolverFactory_GlobalFactory implements Perms_ResolverFactory
{
	function getHash( array $context ) {
		return 'global';
	}

	function getResolver( array $context ) {
		$perms = array();
		$db = TikiDb::get();

		$result = $db->query( 'SELECT groupName, permName FROM users_grouppermissions' );
		while( $row = $result->fetchRow() ) {
			$group = $row['groupName'];
			$perm = $this->sanitize( $row['permName'] );

			if( ! isset( $perms[$group] ) ) {
				$perms[$group] = array();
			}

			$perms[$group][] = $perm;
		}

		return new Perms_Resolver_Static( $perms );
	}

	private function sanitize( $name ) {
		if( strpos( $name, 'tiki_p_' ) === 0 ) {
			return substr( $name, strlen( 'tiki_p_' ) );
		} else {
			return $name;
		}
	}
}

?>
