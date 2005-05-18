<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

class RankLib extends TikiLib {
	function RankLib($db) {
		# this is probably uneeded now
		if (!$db) {
			die ("Invalid db object passed to RankLib constructor");
		}

		$this->db = $db;
	}

	function wiki_ranking_top_pages($limit) {
		$query = "select `pageName`, `hits` from `tiki_pages` order by `hits` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["pageName"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-index.php?page=' . $res["pageName"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki top pages");
		$retval["y"] = tra("Hits");
		$retval["type"] = "nb";
		return $retval;
	}

	function wiki_ranking_top_pagerank($limit) {
		$this->pageRank();

		$query = "select `pageName`, `pageRank` from `tiki_pages` order by `pageRank` desc";
		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["pageName"];

			$aux["hits"] = $res["pageRank"];
			$aux["href"] = 'tiki-index.php?page=' . $res["pageName"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Most relevant pages");
		$retval["y"] = tra("Relevance");
		$retval["type"] = "nb";
		return $retval;
	}

	function wiki_ranking_last_pages($limit) {
		$query = "select `pageName`,`lastModif`,`hits` from `tiki_pages` order by `lastModif` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["pageName"];

			$aux["hits"] = $res["lastModif"];
			$aux["href"] = 'tiki-index.php?page=' . $res["pageName"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki last pages");
		$retval["y"] = tra("Modified");
		$retval["type"] = "date";
		return $retval;
	}

	function forums_ranking_last_topics($limit) {
		$query = "select * from
		`tiki_comments`,`tiki_forums` where
		`object`=".$this->sql_cast("`forumId`","string")." and `objectType` = 'forum' and
		`parentId`=0 order by `commentDate` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"] . ': ' . $res["title"];

			$aux["hits"] = $res["commentDate"];
			$aux["href"] = 'tiki-view_forum_thread.php?forumId=' . $res["forumId"] . '&amp;comments_parentId=' . $res["threadId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Forums last topics");
		$retval["y"] = tra("Topic date");
		$retval["type"] = "date";
		return $retval;
	}

	function forums_ranking_last_posts($limit) {
		$query = "select * from
		`tiki_comments`,`tiki_forums` where
		`object`=".$this->sql_cast("`forumId`","string")." and `objectType` = 'forum'
		order by `commentDate` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"] . ': ' . $res["title"];

			$aux["hits"] = $this->get_long_datetime($res["commentDate"]);
			$tmp = $res["parentId"];
			if ($tmp == 0) $tmp = $res["threadId"];
			$aux["href"] = 'tiki-view_forum_thread.php?forumId=' . $res["forumId"] . '&amp;comments_parentId=' . $tmp;
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Forums last posts");
		$retval["y"] = tra("Topic date");
		$retval["type"] = "date";
		return $retval;
	}

	function forums_ranking_most_read_topics($limit) {
		$query = "select
		tc.`hits`,tc.`title`,tf.`name`,tf.`forumId`,tc.`threadId`,tc.`object`
		from `tiki_comments` tc,`tiki_forums` tf where
		`object`=`forumId` and `objectType` = 'forum' and
		`parentId`=0 order by tc.`hits` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"] . ': ' . $res["title"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-view_forum_thread.php?forumId=' . $res["forumId"] . '&amp;comments_parentId=' . $res["threadId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Forums most read topics");
		$retval["y"] = tra("Reads");
		$retval["type"] = "nb";
		return $retval;
	}

    function forums_top_posters($qty) {
        $query = "select `user`, `posts` from `tiki_user_postings` order by ".$this->convert_sortmode("posts_desc");
        $result = $this->query($query, array(),$qty);
        $ret = array();

        while ($res = $result->fetchRow()) {
            $aux["name"] = $res["user"];
	    $aux["posts"] = $res["posts"];
	    $ret[] = $aux;
        }

	$retval["data"] = $ret;

        return $retval;
    }


	function forums_ranking_top_topics($limit) {
		$query = "select
		tc.`average`,tc.`title`,tf.`name`,tf.`forumId`,tc.`threadId`,tc.`object`
		from `tiki_comments` tc,`tiki_forums` tf where
		`object`=`forumId` and `objectType` = 'forum' and
		`parentId`=0 order by tc.`average` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"] . ': ' . $res["title"];

			$aux["hits"] = $res["average"];
			$aux["href"] = 'tiki-view_forum_thread.php?forumId=' . $res["forumId"] . '&amp;comments_parentId=' . $res["threadId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Forums best topics");
		$retval["y"] = tra("Score");
		$retval["type"] = "nb";
		return $retval;
	}

	function forums_ranking_most_visited_forums($limit) {
		$query = "select * from `tiki_forums` order by `hits` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-view_forum.php?forumId=' . $res["forumId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Forums most visited forums");
		$retval["y"] = tra("Visits");
		$retval["type"] = "nb";
		return $retval;
	}

	function forums_ranking_most_commented_forum($limit) {
		$query = "select * from `tiki_forums` order by `comments` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"];

			$aux["hits"] = $res["comments"];
			$aux["href"] = 'tiki-view_forum.php?forumId=' . $res["forumId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Forums with most posts");
		$retval["y"] = tra("Posts");
		$retval["type"] = "nb";
		return $retval;
	}

	function gal_ranking_top_galleries($limit) {
		$query = "select * from `tiki_galleries` where `visible`=? order by `hits` desc";

		$result = $this->query($query,array('y'),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-browse_gallery.php?galleryId=' . $res["galleryId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki top galleries");
		$retval["y"] = tra("Visits");
		$retval["type"] = "nb";
		return $retval;
	}

	function filegal_ranking_top_galleries($limit) {
		$query = "select * from `tiki_file_galleries` where `visible`=? order by `hits` desc";

		$result = $this->query($query,array('y'),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-list_file_gallery.php?galleryId=' . $res["galleryId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki top file galleries");
		$retval["y"] = tra("Visits");
		$retval["type"] = "nb";
		return $retval;
	}

	function gal_ranking_top_images($limit) {
		$query = "select `imageId`,`name`,`hits` from `tiki_images` order by `hits` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-browse_image.php?imageId=' . $res["imageId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki top images");
		$retval["y"] = tra("Hits");
		$retval["type"] = "nb";
		return $retval;
	}

	function filegal_ranking_top_files($limit) {
		$query = "select `fileId`,`filename`,`downloads` from `tiki_files` order by `downloads` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["filename"];

			$aux["hits"] = $res["downloads"];
			$aux["href"] = 'tiki-download_file.php?fileId=' . $res["fileId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki top files");
		$retval["y"] = tra("Downloads");
		$retval["type"] = "nb";
		return $retval;
	}

	function gal_ranking_last_images($limit) {
		$query = "select `imageId`,`name`,`created` from `tiki_images` order by `created` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["name"];

			$aux["hits"] = $res["created"];
			$aux["href"] = 'tiki-browse_image.php?imageId=' . $res["imageId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki last images");
		$retval["y"] = tra("Upload date");
		$retval["type"] = "date";
		return $retval;
	}

	function filegal_ranking_last_files($limit) {
		$query = "select `fileId`,`filename`,`created` from `tiki_files` order by `created` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["filename"];

			$aux["hits"] = $res["created"];
			$aux["href"] = 'tiki-download_file.php?fileId=' . $res["fileId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki last files");
		$retval["y"] = tra("Upload date");
		$retval["type"] = "date";
		return $retval;
	}

	function cms_ranking_top_articles($limit) {
		$query = "select * from `tiki_articles` order by `reads` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["title"];

			$aux["hits"] = $res["reads"];
			$aux["href"] = 'tiki-read_article.php?articleId=' . $res["articleId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Wiki top articles");
		$retval["y"] = tra("Reads");
		$retval["type"] = "nb";
		return $retval;
	}

	function blog_ranking_top_blogs($limit) {
		$query = "select * from `tiki_blogs` order by `hits` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["title"];

			$aux["hits"] = $res["hits"];
			$aux["href"] = 'tiki-view_blog.php?blogId=' . $res["blogId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Most visited blogs");
		$retval["y"] = tra("Visits");
		$retval["type"] = "nb";
		return $retval;
	}

	function blog_ranking_top_active_blogs($limit) {
		$query = "select * from `tiki_blogs` order by `activity` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$aux["name"] = $res["title"];

			$aux["hits"] = $res["activity"];
			$aux["href"] = 'tiki-view_blog.php?blogId=' . $res["blogId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Most active blogs");
		$retval["y"] = tra("Activity");
		$retval["type"] = "nb";
		return $retval;
	}

	function blog_ranking_last_posts($limit) {
		$query = "select * from `tiki_blog_posts` order by `created` desc";

		$result = $this->query($query,array(),$limit,0);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$q = "select `title` from `tiki_blogs` where `blogId`=?";

			$name = $this->getOne($q,array($res["blogId"]));
			$aux["name"] = $name;
			$aux["hits"] = $res["created"];
			$aux["href"] = 'tiki-view_blog.php?blogId=' . $res["blogId"];
			$ret[] = $aux;
		}

		$retval["data"] = $ret;
		$retval["title"] = tra("Blogs last posts");
		$retval["y"] = tra("Post date");
		$retval["type"] = "date";
		return $retval;
	}

	function wiki_ranking_top_authors($limit) {
		$query = "select distinct `user`, count(*) as `numb` from `tiki_pages` group by `user` order by ".$this->convert_sortmode("numb_desc");

		$result = $this->query($query,array(),$limit,0);
		$ret = array();
		$retu = array();

		while ($res = $result->fetchRow()) {
			$ret["name"] = $res["user"];
			$ret["hits"] = $res["numb"];
			$ret["href"] = "tiki-user_information.php?view_user=".urlencode($res["user"]);
			$retu[] = $ret;
		}
		$retval["data"] = $retu;
		$retval["title"] = tra("Wiki top authors");
		$retval["y"] = tra("Pages");
		$retval["type"] = "nb";
		return $retval;
	}

	function cms_ranking_top_authors($limit) {
		$query = "select distinct `author`, count(*) as `numb` from `tiki_articles` group by `author` order by ".$this->convert_sortmode("numb_desc");

		$result = $this->query($query,array(),$limit,0);
		$ret = array();
		$retu = array();

		while ($res = $result->fetchRow()) {
			$ret["name"] = $res["author"];
			$ret["hits"] = $res["numb"];
			$ret["href"] = "tiki-user_information.php?view_user=".urlencode($res["author"]);
			$retu[] = $ret;
		}
		$retval["data"] = $retu;
		$retval["title"] = tra("Top article authors");
		$retval["y"] = tra("Articles");
		$retval["type"] = "nb";
		return $retval;
	}

}

$ranklib = new RankLib($dbTiki);

?>
