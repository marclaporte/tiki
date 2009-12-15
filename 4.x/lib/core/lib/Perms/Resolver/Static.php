<?php

/**
 * Resolver containing the list of permissions for each group as a
 * static list. The resolvers are generated by factories and apply
 * for a specific context.
 */
class Perms_Resolver_Static implements Perms_Resolver
{
	private $known = array();

	function __construct( array $known ) {
		foreach( $known as $group => $perms ) {
			$this->known[$group] = array_fill_keys( $perms, true );
		}
	}

	function check( $name, array $groups ) {
		foreach( $groups as $groupName ) {
			if( isset( $this->known[$groupName] ) ) {
				if( isset( $this->known[$groupName][$name] ) ) {
					return true;
				}
			}
		}

		return false;
	}
}
