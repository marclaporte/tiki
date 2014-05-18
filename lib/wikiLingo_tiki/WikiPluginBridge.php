<?php

use WikiLingo\Plugin\Base;
use WikiLingo\Expression\Plugin;

class WikiPluginBridge extends Base
{
	public function __construct()
	{
		$this->allowLines = true;
	}

	/**
	 * @param Plugin $plugin
	 * @param string $body
	 * @param \WikiLingo\Renderer $renderer
	 * @param \WikiLingo\Parser $parser
	 * @return mixed|string
	 */
	public function render(Plugin &$plugin, &$body, &$renderer, &$parser)
	{
		$name = strtolower($plugin->type);
		$fileLocation = "lib/wiki-plugins/wikiplugin_" . $name . ".php";
		if (file_exists($fileLocation)) {
			require_once($fileLocation);
			$fn = "wikiplugin_" . $name;

			if ($plugin->parsed->type === 'Plugin') {
				$body = $parser->syntaxBetween($plugin->parsed->arguments[0]->loc, $plugin->parsed->stateEnd->loc);
			}

			//$arguments = $this->argumentsParser->parse($plugin->parsed->arguments[0]->text);

			$output = $fn($body, $plugin->parametersRaw);
			$output = TikiLib::lib("parser")->parse_data($output, array('is_html' => true));

			return $output;
		}
		return '';
	}
}