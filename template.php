<?php
// this removes the Read More link on the front page
function islandora_default_preprocess_node(&$variables) {
	unset($variables['content']['links']['node']);
	}

/*function yourthemename_preprocess_page(&$vars) {
	if (isset($vars['node']->type)) { $vars['theme_hook_suggestions'][] = 'page__' . $vars['node']->type;
	}
} */

function islandora_default_preprocess_page(&$vars, $hook) {
  if (isset($vars['node']))
	{
    // If the node type is "blog_madness" the template suggestion will be "page--blog-madness.tpl.php".
    $vars['theme_hook_suggestions'][] = 'page__'. $vars['node']->type;
	}
}

function islandora_default_preprocess_html(&$vars) {
	$viewport = array(
		'#tag' => 'meta',
		'#attributes' => array(
			'name' => 'viewport',
			'content' => 'width=device-width, initial-scale=1, maximum-scale=1',
			 ),
		 );
		 drupal_add_html_head($viewport, 'viewport');
	}

function islandora_default_islandora_internet_archive_bookreader_book_info(array $variables) {
  $object = $variables['object'];
  $fields = islandora_internet_archive_bookreader_info_fields($object);
  $convert_to_string = function($o) {
    return implode('<br/>', $o);
  };
  $fields = array_map($convert_to_string, $fields);
  $rows = array_map(NULL, array_keys($fields), array_values($fields));
  $content = theme('table', array(
               'caption' => '',
               'empty' => t('No Information specified.'),
               'attributes' => array(),
               'colgroups' => array(),
               'header' => array(t('Field'), t('Values')),
               'rows' => $rows,
               'sticky' => FALSE));
  return $content;
}



?>
