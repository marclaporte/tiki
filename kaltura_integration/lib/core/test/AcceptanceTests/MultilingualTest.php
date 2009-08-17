<?php

/*************************************************************
* Automated acceptance tests for Multilingual Features.
*************************************************************/


require_once 'TikiSeleniumTestCase.php';

class  AcceptanceTests_MultilingualTest extends TikiSeleniumTestCase
{

	public function __testRememberToReactivateAllTestsInMultilingualTest() {
    	$this->fail("Don't forget to do this");
    }
        
   public function testHomePageIsMultilingual() {
   		$this->openTikiPage('tiki-index.php');
   		$this->logInIfNecessaryAs('admin');
   		$this->assertLanguagePicklistHasLanguages(array('English' => 'HomePage'));
   }
    
    public function testMultilingualPageDisplaysLanguagePicklist() {
       	$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
       	$this->logInIfNecessaryAs('admin');
       	$this->assertLanguagePicklistHasLanguages(array('English' => 'Multilingual Test Page 1', 
                                                    'Français' => 'Page de test multilingue 1'));                                                    
    }

    public function testSwitchBetweenLanguages() {
       $this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
       $this->logInIfNecessaryAs('admin');
       $this->doSwitchLanguageTo('Français');
       $this->assertTrue(preg_match("/page\=Page\+de\+test\+multilingue\+1/",$this->getLocation()) == 1);
    }
    
  	
  	public function testLanguageLinkLeadsToTranslatedPageInThatLanguage() {
  		$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
  		$this->logInIfNecessaryAs('admin');
  		$this->doSwitchLanguageTo('Français');
  		$this->assertTrue(preg_match('/page=Page\+de\+test\+multilingue\+1/', $this->getLocation()) == 1);
    	$this->assertElementPresent("link=Page de test multilingue 1");
    	$this->assertLanguagePicklistHasLanguages(array('Français' => 'Page de test multilingue 1', 
													'English' => 'Multilingual Test Page 1' 
                                                    ));	
  	}
  	
  	public function testTranslateOptionAppearsOnlyWhenLoggedIn() {
  		$this->openTikiPage('tiki-index.php');
  		$this->logOutIfNecessary();
  		$this->assertLanguagePicklistHasNoTranslateOption();
  		$this->logInIfNecessaryAs('admin');
  		$this->assertLanguagePicklistHasTranslateOption();
  	}

    public function testClickOnTranslateShowsTranslatePage() {
    	$this->openTikiPage('tiki-index.php');
    	$this->logInIfNecessaryAs('admin');
    	$this->select("page", "label=Translate");
    	$this->waitForPageToLoad("30000");
    	$this->assertElementPresent("link=exact:Translate: HomePage (English, en)");
  	}

  	
  	public function testListOfLanguagesOnTranslatePageDoesNotContainAlreadyTranslatedLanguages() {
  		$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->select("page", "label=Translate");
    	$this->waitForPageToLoad("30000");
    	$this->assertSelectElementDoesNotContainItems(
                      "xpath=id('tiki-center')/form[1]/p/select[@name='lang']",
					   array('English' => 'en'),
					  "English should not have been present in the list of languages.");
  	}
    
    public function testCannotGiveATranslationTheNameOfAnExistingPage() {
    	//NB. This is in fact wrong. If you have similar languages, say English and British English, 
    	//or Serbian (latin alphabet) and Croatian, the title of the page is bound to be the same. Here we force
    	//the translator to add a language tag to the title only to have the unique page name
    	//A multilingual system should add a language ID to the page name without the user's 
    	//intervention.
    	$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->doSwitchLanguageTo('Français');
    	$this->clickAndWait("link=Translate");
    	$this->select("language_list", "label=English British (en-uk)");
    	$this->type("translation_name", "Multilingual Test Page 1");
    	$this->clickAndWait("//input[@value='Create translation']");
        $this->assertTrue($this->isTextPresent("Page already exists. Go back and choose a different name."));
        
        
    }
    
    public function testShouldNotChangeLanguageOfThePageInCaseCreateTranslationFails() {
    	//In case when a page already exists create translation gives an error message which is ok.
    	//But it shouldn't change the language of the existing page to the language chosen for translation. 
    	$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->doSwitchLanguageTo('Français');
    	$this->clickAndWait("link=Translate");
    	$this->select("language_list", "label=English British (en-uk)");
    	$this->type("translation_name", "Multilingual Test Page 1");
    	$this->clickAndWait("//input[@value='Create translation']");
        $this->assertTrue($this->isTextPresent("Page already exists. Go back and choose a different name."));
        $this->clickAndWait("link=Go back");
    	$this->clickAndWait("link=View Page");
    	//A bug: instead of English it shows English British although the page was not created
       	$this->assertLanguagePicklistHasLanguages(array('Français' => 'Page de test multilingue 1', 
													'English' => 'Multilingual Test Page 1' 
                                                    ));                                                    
       	$this->assertLanguagePicklistDoesNotHaveLanguages(array('English British' => 'Multilingual Test Page 1' 
                                                    ));                                                    
    }
    
    
    public function testUpToDatenessIs100percentForTheCompletelyTranslatedPages(){
    	$this->openTikiPage('tiki-index.php?page=Page+de+test+multilingue+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->assertTextPresent("Up-to-date-ness: 100%");
    	$this->assertTextPresent("Equivalent translations: Multilingual Test Page 1 (en)");
    }
 

    public function testUponAddingNewContentTranslationsThatNeedImprovementAppears() {
    	$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->clickAndWait("link=Edit");
    	$this->type("editwiki", "This is the first multilingual test page.\n\nAdding some text yet to be translated.");
    	$this->clickAndWait("save");
        $this->click("link=More...");
        $this->assertTextPresent("Translations that need improvement: None match your preferred languages.\n More... Page de test multilingue 1 (fr)");
        $this->assertElementPresent("link=Page de test multilingue 1");
        $this->clickAndWait("link=Page de test multilingue 1");
		//assert that up-to-dateness is now less than 100%
    	$this->assertRegExp("/Up-to-date-ness: [0-9]{2}%/", $this->getText("//div[@id='mod-translationr10']/div[1]"), "Up-to-dateness should have been less than 100%.");
    	$this->assertTextPresent("Better translations: Multilingual Test Page 1 (en)");
    }
    
    public function testCompleteTranslationBringsBackUpToDatenessTo100() {
    	$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->clickAndWait("link=Edit");
    	$this->type("editwiki", "This is the first multilingual test page.\n\nAdding some text yet to be translated.");
    	$this->clickAndWait("save");
        $this->click("link=More...");
   		$this->clickAndWait("//img[@alt='update it']");
    	$this->type("editwiki", "Ceci est la première page multilingue de test.\n\nAjout du texte à traduire.");
    	$this->clickAndWait("save");
    	$this->assertTextPresent("Up-to-date-ness: 100%");
    	$this->assertTextPresent("Equivalent translations: Multilingual Test Page 1 (en)");
    	$this->clickAndWait("link=Multilingual Test Page 1");
    	$this->assertTextPresent("Up-to-date-ness: 100%");
    }
    
    public function testPartialTranslationBringsUpUpToDatenessPourcentage() {
		$this->openTikiPage('tiki-index.php?page=Multilingual+Test+Page+1');
    	$this->logInIfNecessaryAs('admin');
    	$this->clickAndWait("link=Edit");
    	$this->type("editwiki", "This is the first multilingual test page.\n\nAdding some text yet to be translated.");
    	$this->clickAndWait("save");
        $this->click("link=More...");
        $this->clickAndWait("link=Page de test multilingue 1");
        $this->assertRegExp("/Up-to-date-ness: [0-9]{2}%/", $this->getText("//div[@id='mod-translationr10']/div[1]"));
        if (preg_match("/Up-to-date-ness: ([0-9]{2})%/", $this->getText("//div[@id='mod-translationr10']/div[1]"), $matches)) {
        	$first_percentage = $matches[1];
        }
   		$this->clickAndWait("//img[@alt='update from it']");
    	$this->type("editwiki", "Ceci est la première page multilingue de test.\n\nAjout du texte à traduire.");
    	$this->clickAndWait("partial_save");
    	$this->assertRegExp("/Up-to-date-ness: [0-9]{2}%/", $this->getText("//div[@id='mod-translationr10']/div[1]"));
    	if (preg_match("/Up-to-date-ness: ([0-9]{2})%/", $this->getText("//div[@id='mod-translationr10']/div[1]"), $matches)) {
        	$second_percentage = $matches[1];
        }
    	$this->assertTrue($second_percentage > $first_percentage, "Up-to-dateness should have been higher than $first_percentage. It was $second_percentage.");
    }
    
    
    
     
    
   
    /**************************************
     * Helper methods
     **************************************/

    protected function setUp()
    {
        $this->printImportantMessageForTestUsers();
        $this->setBrowser('*firefox C:\Program Files\Mozilla Firefox\firefox.exe');
        $this->setBrowserUrl('http://localhost/');
        $this->current_test_db = "multilingualTestDump.sql";
        $this->restoreDBforThisTest();
    }
    
    public function printImportantMessageForTestUsers() {
       die("MultilingualTest will not work unless:\n".
                   "- the name of the Tiki db is 'tiki_db_for_acceptance_tests' and \n".
				   "- the file 'multilingualTestDump.sql' (check it out from mods/acceptance_tests_files) is copied in the mySql data directory.\n" .
				   "Comment out the call to printImportantMessageForTestUsers() in MultilingualTest::setUp() to run the tests.\n");
    }
    
    

    public function assertLanguagePicklistHasLanguages($expAvailableLanguages) {
        $this->assertSelectElementContainsItems("xpath=//select[@name='page' and @onchange='quick_switch_language( this )']",
                  $expAvailableLanguages, 
                  "Language picklist was wrong. It should have contained ".$this->implode_with_key(",", $expAvailableLanguages)." but didn't.");           
    }
    
    public function doSwitchLanguageTo($language) {
		$this->select("page", "label=$language");
		$this->waitForPageToLoad("30000");
    }   
    public function assertLanguagePicklistDoesNotHaveLanguages($expAvailableLanguages) {
    	$this->assertSelectElementDoesNotContainItems("xpath=//select[@name='page' and @onchange='quick_switch_language( this )']",
                  $expAvailableLanguages, 
                  "Language picklist was wrong. It contained ".$this->implode_with_key(",", $expAvailableLanguages)." but shouldn't.");
    }
    
    public function assertLanguagePicklistHasTranslateOption() {
        $this->assertElementPresent("xpath=//select[@name='page' and @onchange='quick_switch_language( this )']/option[@value='_translate_']",
                  "Translate option was not present.");           
    }
    
    public function assertLanguagePicklistHasNoTranslateOption() {
        $this->assertFalse($this->isElementPresent("xpath=//select[@name='page' and @onchange='quick_switch_language( this )']/option[@value='_translate_']",
                  "Translate option was present."));           
    }
}
