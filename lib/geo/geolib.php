<?php

class GeoLib
{
	function get_coordinates($type, $itemId) {
		$attributelib = TikiLib::lib('attribute');

		$attributes = $attributelib->get_attributes($type, $itemId);

		if (isset($attributes['tiki.geo.lat'], $attributes['tiki.geo.lon'])) {
			$coords = array(
				'lat' => $attributes['tiki.geo.lat'],
				'lon' => $attributes['tiki.geo.lon'],
			);

			if (! empty($attributes['tiki.geo.google.zoom'])) {
				$coords['zoom'] = $attributes['tiki.geo.google.zoom'];
			}

			return $coords;
		}
	}

	function get_coordinates_string($type, $itemId) {
		if ($coords = $this->get_coordinates($type, $itemId)) {
			return $this->build_location_string($coords);
		}
	}
	
	function build_location_string($coords) {
		if (! empty($coords['lat']) && ! empty($coords['lon'])) {
			$string = "{$coords['lat']},{$coords['lon']}";

			if (! empty($coords['zoom'])) {
				$string .= ",{$coords['zoom']}";
			}

			return $string;
		}
	}

	function set_coordinates($type, $itemId, $coordinates) {
		if (is_string($coordinates)) {
			$coordinates = $this->parse_coordinates($coordinates);
		}

		if (isset($coordinates['lat'], $coordinates['lon'])) {
			$attributelib = TikiLib::lib('attribute');
			$attributelib->set_attribute($type, $itemId, 'tiki.geo.lat', $coordinates['lat']);
			$attributelib->set_attribute($type, $itemId, 'tiki.geo.lon', $coordinates['lon']);

			if (isset($coordinates['zoom'])) {
				$attributelib->set_attribute($type, $itemId, 'tiki.geo.google.zoom', $coordinates['zoom']);
			}
		}
	}

	function parse_coordinates($string) {
		if (preg_match("/^(-?\d*(\.\d+)?),(-?\d*(\.\d+)?)(,(\d+))?$/", $string, $parts)) {
			$coords = array(
				'lat' => $parts[1],
				'lon' => $parts[3],
			);

			if (! empty($parts[6])) {
				$coords['zoom'] = $parts[6];
			}

			return $coords;
		}
	}
	
	function geocode($where) {
		global $prefs;
		$where = stripslashes($where);
		$whereurl = urlencode($where);
		$googlekey = $prefs["gmap_key"];
		if (!$googlekey) {
			return false;
		}
		$location = file("http://maps.google.com/maps/geo?q=$whereurl&output=csv&key=$googlekey");
		list ($stat,$acc,$north,$east) = explode(",",$location[0]);
		$ret = array(
			'status' => $stat,
			'accuracy' => $acc,
			'lat' => $north,
			'lon' => $east,
		);
		if ($stat != '200') {
			return false;
		}
		return $ret;
	}
	
	function geofudge($geo) {
		if (!$geo) {
			return false;
		}
		if (empty($geo["lon"]) || empty($geo["lat"])) {
			return array("lon" => 0, "lat" => 0);
		}
		$geo["lon"] = $geo["lon"] + rand(0, 10000) / 8000;
		$geo["lat"] = $geo["lat"] + rand(0, 10000) / 10000;
		return $geo;
	}
	
	function setTrackerGeo($itemId, $geo) {
		global $prefs, $trklib;
		if (!is_object($trklib)) {
			include_once('lib/trackers/trackerlib.php');
		}
		$item = $trklib->get_tracker_item($itemId);
		$fields = $trklib->list_tracker_fields($item['trackerId']);
		foreach ($fields["data"] as $f) {
			if ($f["type"] == 'G' && $f["options_array"][0] == 'y') {
				$fieldId = $f["fieldId"];
				$options_array = $f["options_array"];
				$pointx = $geo['lon'];
				$pointy = $geo['lat'];
				$pointz = $prefs["gmap_defaultz"];
				break;
			}
		}
		if (isset($fieldId)) {
			$ins_fields["data"][$fieldId] = array('fieldId' => $fieldId, 'options_array' => $options_array, 'value' => "$pointx,$pointy,$pointz", 'type' => 'G');
			$res = $trklib->replace_item($item['trackerId'], $itemId, $ins_fields);
		}
	}

}

$geolib = new GeoLib;
