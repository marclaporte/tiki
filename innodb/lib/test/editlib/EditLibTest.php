<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

/**
 * @group unit
 *
 */


class EditLibTest extends TikiTestCase
{
	private $el = null; // the EditLib
	private $dir = '';  // the unmodifed directory

	function __construct() {
		$this->dir = getcwd();
	}
		
	
	function setUp() {
		$this->el = new EditLib();
		chdir($this->dir);
		chdir('../../'); // the tiki installation directory
	}
	
		
	function tearDown() {
		chdir($this->dir);
	}

	
	function testParseColor() {
		
		$el = new EditLib();
		
		$col = 'rgb( 255 , 0 , 0 )'; 
		$hex = $el->parseColor($col);
		$this->assertEquals('#FF0000', $hex);
		
		$col = 'rgb(255,0,0)';
		$hex = $el->parseColor($col);
		$this->assertEquals('#FF0000', $hex);
		
		$col = 'rgb(0, 255,0)';
		$hex = $el->parseColor($col);
		$this->assertEquals('#00FF00', $hex);
		
		$col = 'rgb(0,0,255)';
		$hex = $el->parseColor($col);
		$this->assertEquals('#0000FF', $hex);
		
		$col = '#FF0000';
		$hex = $el->parseColor($col);
		$this->assertEquals('#FF0000', $hex);
	}
	
	
	function testParseStyleAttribute() {
		
		$el = new EditLib();
		
		/*
		 * empty style -> empty array
		 */
		$style = '';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(0, count($parsed));

		
		/*
		 * delimiters only -> empty array
		 */
		$style = ' ; ; ';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(0, count($parsed));
		
		
		/*
		 * examples, no shortand lists
		 */
		$style = 'unknown-list:rgb(1,2,3) url(background.gif);unknown-size:12;';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(2, count($parsed));
		$this->assertTrue(isset($parsed['unknown-list']));
		$this->assertEquals('rgb(1,2,3) url(background.gif)', $parsed['unknown-list']);
		$this->assertTrue(isset($parsed['unknown-size']));
		$this->assertEquals(12, $parsed['unknown-size']);
		
		$style = 'unknown-list:rgb(1,2,3) url(background.gif);unknown-size:12';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(2, count($parsed));
		$this->assertTrue(isset($parsed['unknown-list']));
		$this->assertEquals('rgb(1,2,3) url(background.gif)', $parsed['unknown-list']);
		$this->assertTrue(isset($parsed['unknown-size']));
		$this->assertEquals(12, $parsed['unknown-size']);
		
		$style = ' unknown-list : rgb( 1 , 2 , 3 ) url( background.gif )   ;   unknown-size: 12 ; ';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(2, count($parsed));
		$this->assertTrue(isset($parsed['unknown-list']));
		$this->assertEquals('rgb( 1 , 2 , 3 ) url( background.gif )', $parsed['unknown-list']);
		$this->assertTrue(isset($parsed['unknown-size']));
		$this->assertEquals(12, $parsed['unknown-size']);	

		
		/*
		 * examples with shorthand list 'background'
		 */
		$style = 'background-color:#FF0000';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(1, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('#FF0000', $parsed['background-color']);
		
		$style = 'background:#FF0000';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(1, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('#FF0000', $parsed['background-color']);

		$style = 'background:rgb(0, 0, 0);';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(1, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('rgb(0, 0, 0)', $parsed['background-color']);

		$style = 'background: rgb(0, 255, 0); background-color:rgb(255, 0, 0);';		
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(1, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('rgb(255, 0, 0)', $parsed['background-color']);				
		
		$style = 'background-color:rgb(255, 0, 0); background: rgb(0, 255, 0);';		
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(1, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('rgb(0, 255, 0)', $parsed['background-color']);		
		
		$style = 'background-color:rgb(255, 0, 0); background: rgb(0, 255, 0) #0000FF;';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(1, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('#0000FF', $parsed['background-color']);				

		$style = 'background-color:rgb(255, 0, 0); background: rgb(0, 255, 0) unknown1 #0000FF unknown2;';
		$parsed = array();
		$el->parseStyleAttribute($style, $parsed);
		$this->assertEquals(2, count($parsed));
		$this->assertTrue(isset($parsed['background-color']));
		$this->assertEquals('#0000FF', $parsed['background-color']);				
		$this->assertTrue(isset($parsed['background']));
		$this->assertEquals('unknown1 unknown2', $parsed['background']);				
	}
	
	
	function testParseStyleList() {
		
		$el = new EditLib();
		
		
		/*
		 * empty
		 */
		$list = '';
		$parsed = array();
		$el->parseStyleList($list, $parsed);
		$this->assertEquals(0, count($parsed));
		
		
		/*
		 * mixed examples
		 */
		$list = 'rgb(0, 255, 0) #0000FF';
		$parsed = array();
		$el->parseStyleList($list, $parsed);
		$this->assertEquals(2, count($parsed));
		$this->assertEquals('rgb(0, 255, 0)', $parsed[0]);
		$this->assertEquals('#0000FF', $parsed[1]);
		
		$list = 'rgb( 1 , 2 , 3 )   20px    url( background-example.gif )';
		$parsed = array();
		$el->parseStyleList($list, $parsed);
		$this->assertEquals(3, count($parsed));
		$this->assertEquals('rgb( 1 , 2 , 3 )', $parsed[0]);
		$this->assertEquals('20px', $parsed[1]);
		$this->assertEquals('url( background-example.gif )', $parsed[2]);
	}
	
	
	function testParseToWikiSpaces() {
		$this->markTestIncomplete('Work in progress.');
		
		$el = new EditLib();
		
		/*
		 * The EditLib r35862 eats spaces before the tags
		 */
		$inData = 'abc <b> bold </b> def';
		$res = $el->parseToWiki($inData);
		$this->assertEquals('abc __ bold __ def', $res);
	}
	
	
	/**
	 * Nested wiki inline tags
	 * 
	 * This test verifies that the tags are written in the correct
	 * order to the output stream.
	 */
	function testParseToWikiNestedInline() {
		
		$ex = '__bold\'\'bold italic\'\'__\n__\'\'bold italic\'\'__';
		$inData = '<strong>bold<em>bold italic<br />bold italic</em></strong>';
		$res = $this->el->parseToWiki($inData);
		$res = preg_replace('/\n/', '\n', $res); // fix LF encoding for comparison
		$this->assertEquals($ex, $res);
		
		$ex = '__bold\'\'bold italic\'\'__\n__bold__';
		$inData = '<strong>bold<em>bold italic</em><br />bold</strong>';
		$res = $this->el->parseToWiki($inData);
		$res = preg_replace('/\n/', '\n', $res); // fix LF encoding for comparison
		$this->assertEquals($ex, $res);	

		$ex = '__\'\'bold italic\'\'__\n__\'\'BOLD ITALIC\'\'__';
		$inData = '<span style="font-weight:bold;font-style:italic">bold italic<br />BOLD ITALIC</span>';
		$res = $this->el->parseToWiki($inData);
		$res = preg_replace('/\n/', '\n', $res); // fix LF encoding for comparison
		$this->assertEquals($ex, $res);	
	}
	
	
	function testSpanNestedDecorations() {
		$this->markTestIncomplete('Work in progress.');
		$ex = '--===text===--';
		$inData = '<span style="text-decoration:line-through underline;">text</span>';
		$res = $this->el->parseToWiki($inData);
		$this->assertEquals($ex, $res);	
	}
}