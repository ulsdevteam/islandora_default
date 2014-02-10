<?php

// this removes the Read More link on the front page
function islandora_default_preprocess_node(&$variables) {
  unset($variables['content']['links']['node']);
}

/* function yourthemename_preprocess_page(&$vars) {
  if (isset($vars['node']->type)) { $vars['theme_hook_suggestions'][] = 'page__' . $vars['node']->type;
  }
  } */

/* function islandora_default_preprocess_page(&$vars, $hook) {   #### commented to test the new node function (line 50)
  if (isset($vars['node']))
  { */

// If the node type is "blog_madness" the template suggestion will be "page--blog-madness.tpl.php".
/* $vars['theme_hook_suggestions'][] = 'page__'. $vars['node']->type;
  }
  } */

function islandora_default_preprocess_page(&$vars) {
  $front = (isset($vars['is_front']) ? $vars['is_front'] : FALSE);
  $type = (isset($vars['node']->type) ? $vars['node']->type : NULL);
  if (!$front) {
    switch ($type) {
      case 'collection':
      case 'exhibit':
      case 'formats':
      case 'partners':
      case 'places':
      case 'multi':
        $vars['theme_hook_suggestions'][] = 'page__two';
        break;
      default:
        break;
    }
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

function islandora_default_preprocess(&$variables, $hook) {
  $islandora_object = (isset($variables['islandora_object']) ? $variables['islandora_object'] : (isset($variables['object']) ? $variables['object'] : NULL));
  if (isset($islandora_object->id)) {
    switch ($hook) {
      case 'islandora_large_image':
      case 'islandora_audio':
      case 'islandora_basic_image':
      case 'islandora_book_book':
      case 'islandora_pdf':
      case 'islandora_video':
        $variables['metadata_link'] = l(t("return to object page"), "islandora/object/{$islandora_object->id}");
        break;
      default:
        break;
    }
  }
}

?>