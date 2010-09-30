<?php

require_once(dirname(__FILE__) . '/tikiimporter_testcase.php');
require_once(dirname(__FILE__) . '/../../importer/tikiimporter_blog.php');

/** 
 * @group importer
 */
class TikiImporter_Blog_Test extends TikiImporter_TestCase
{
    
    public function testImportShouldCallMethodsToStartImportProcess()
    {
        $obj = $this->getMock('TikiImporter_Blog', array('validateInput', 'parseData', 'insertData'));
        $obj->expects($this->once())->method('validateInput');
        $obj->expects($this->once())->method('parseData');
        $obj->expects($this->once())->method('insertData');

        $this->expectOutputString("\nImportation completed!\n\n<b><a href=\"tiki-importer.php\">Click here</a> to finish the import process</b>");
        $obj->import();
   }

    public function testImportShouldSetSessionVariables()
    {
        $expectedImportFeedback = array('importedPages' => 10, 'totalPages' => '13');
        $obj = $this->getMock('TikiImporter_Blog', array('validateInput', 'parseData', 'insertData', 'saveAndDisplayLog'));
        $obj->expects($this->once())->method('validateInput'); 
        $obj->expects($this->once())->method('parseData');
        $obj->expects($this->once())->method('insertData')->will($this->returnValue($expectedImportFeedback));
        $obj->expects($this->once())->method('saveAndDisplayLog');
        
        $obj->log = 'some log string';
        $obj->import();

        $this->assertEquals($expectedImportFeedback, $_SESSION['tiki_importer_feedback']);
        $this->assertEquals('some log string', $_SESSION['tiki_importer_log']);
    }

    public function testInsertDataCallInsertPageFourTimes()
    {
        $obj = $this->getMock('TikiImporter_Blog', array('insertPage', 'insertPost', 'createBlog'));
        $obj->expects($this->once())->method('createBlog');
        $obj->expects($this->exactly(2))->method('insertPage');
        $obj->expects($this->exactly(4))->method('insertPost');
		$parsedData = array(
			array('type' => 'post', 'name' => 'Any name'),
			array('type' => 'post', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'post', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'post', 'name' => 'Any name'),
		);
        $obj->insertData($parsedData);
    }

    public function testInsertDataShouldNotCallInsertPage()
    {
        $obj = $this->getMock('TikiImporter_Blog', array('insertPage', 'createBlog'));
        $obj->expects($this->once())->method('createBlog');
        $obj->expects($this->never())->method('insertPage');
        $parsedData = array();
        $obj->insertData($parsedData);
    }

    public function testInsertDataShouldReturnCountData()
    {
        $obj = $this->getMock('TikiImporter_Blog', array('insertPage', 'createBlog'));
        $obj->expects($this->once())->method('createBlog');
        $obj->expects($this->exactly(6))->method('insertPage')->will($this->onConsecutiveCalls(true, true, false, true, false, true));

		$parsedData = array(
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
			array('type' => 'page', 'name' => 'Any name'),
		);

        $countData = $obj->insertData($parsedData);
        $expectedResult = array('totalPages' => 6, 'importedPages' => 4);

        $this->assertEquals($expectedResult, $countData);
	}

	public function testInsertPage()
	{
		$importerWiki = $this->getMock('TikiImporter_Wiki', array('insertPage'));
		$importerWiki->expects($this->once())->method('insertPage');
		$obj = $this->getMock('TikiImporter_Blog', array('instantiateImporterWiki'));
		$obj->expects($this->once())->method('instantiateImporterWiki');

		$obj->importerWiki = $importerWiki;

		$obj->insertPage(array());
	}
}
/*
class TikiImporter_Wiki_InsertPage_Test extends TikiImporter_TestCase
{

    protected function setUp()
    {
        require_once(dirname(__FILE__) . '/fixtures/mediawiki_page_as_array.php');
        global $tikilib;
        $tikilib = $this->getMock('TikiLib', array('create_page', 'update_page', 'page_exists', 'remove_all_versions'));
        $this->obj = new TikiImporter_Wiki_Mediawiki;
        $this->obj->revisionsNumber = 0;
    }

    public function testInsertPage()
    {
        global $tikilib, $page;

        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(false));
        $tikilib->expects($this->once())->method('create_page')->with($page['name'], 0, $page['revisions'][0]['data'], $page['revisions'][0]['lastModif'], $page['revisions'][0]['comment'], $page['revisions'][0]['user'], $page['revisions'][0]['ip']);
        // TODO: how to test parameters for update_page for the 7 different calls
        $tikilib->expects($this->exactly(7))->method('update_page');

        // $page is set on mediawiki_page_as_array.php
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageAlreadyExistentPageNameOverride()
    {
        global $tikilib, $page;
        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(true));
        $tikilib->expects($this->once())->method('remove_all_versions')->with($page['name']);
        $tikilib->expects($this->once())->method('create_page');
        $tikilib->expects($this->exactly(7))->method('update_page');

        $this->obj->alreadyExistentPageName = 'override';
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageAlreadyExistentPageNameAppendPrefix()
    {
        global $tikilib, $page;

        $newPageName = $this->obj->softwareName . '_' . $page['name'];

        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(true));
        $tikilib->expects($this->once())->method('create_page')->with($newPageName);
        $tikilib->expects($this->exactly(7))->method('update_page')->with($newPageName);

        $this->obj->alreadyExistentPageName = 'appendPrefix';
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageAlreadyExistentPageNameDoNotImport()
    {
        global $tikilib, $page;

        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(true));
        $tikilib->expects($this->never())->method('create_page');
        $tikilib->expects($this->never())->method('update_page');

        $this->obj->alreadyExistentPageName = 'doNotImport';
        $this->assertFalse($this->obj->insertPage($page));
    }
}*/
