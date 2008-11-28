<?php

class DeclFilter_ConfigureTest extends PHPUnit_Framework_TestCase
{
	function testSimple()
	{
		$configuration = array(
			array( 'staticKeyFilters' => array(
				'hello' => 'digits',
				'world' => 'alpha',
			) ),
			array( 'staticKeyFiltersForArrays' => array(
				'foo' => 'digits',
			) ),
			array( 'catchAllFilter' => new Zend_Filter_StringToUpper ),
		);

		$filter = DeclFilter::fromConfiguration( $configuration );

		$data = $filter->filter( array(
			'hello' => '123abc',
			'world' => '123abc',
			'foo' => array(
				'abc123',
				'def456',
			),
			'bar' => 'undeclared',
		) );

		$this->assertEquals( $data['hello'], '123' );
		$this->assertEquals( $data['world'], 'abc' );
		$this->assertContains( '123', $data['foo'] );
		$this->assertContains( '456', $data['foo'] );
		$this->assertEquals( $data['bar'], 'UNDECLARED' );
	}

	/**
	 * Triggered errors become exceptions...
	 * @expectedException Exception
	 */
	function testDisallowed()
	{
		$configuration = array(
			array( 'catchAllFilter' => new Zend_Filter_StringToUpper ),
		);

		$filter = DeclFilter::fromConfiguration( $configuration, array( 'catchAllFilter' ) );
	}

	function testUnsetSome()
	{
		$configuration = array(
			array( 'staticKeyUnset' => array( 'hello', 'world' ) ),
			array( 'catchAllFilter' => new Zend_Filter_StringToUpper ),
		);

		$filter = DeclFilter::fromConfiguration( $configuration );

		$data = $filter->filter( array(
			'hello' => '123abc',
			'world' => '123abc',
			'bar' => 'undeclared',
		) );

		$this->assertFalse( isset( $data['hello'] ) );
		$this->assertFalse( isset( $data['world'] ) );
		$this->assertEquals( $data['bar'], 'UNDECLARED' );
	}

	function testUnsetOthers()
	{
		$configuration = array(
			array( 'staticKeyFilters' => array(
				'hello' => 'digits',
				'world' => 'alpha',
			) ),
			array( 'catchAllUnset' => null ),
		);

		$filter = DeclFilter::fromConfiguration( $configuration );

		$data = $filter->filter( array(
			'hello' => '123abc',
			'world' => '123abc',
			'bar' => 'undeclared',
		) );

		$this->assertEquals( $data['hello'], '123' );
		$this->assertEquals( $data['world'], 'abc' );
		$this->assertFalse( isset( $data['bar'] ) );
	}
}

?>
