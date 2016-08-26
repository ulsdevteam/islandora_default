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

/*function islandora_default_preprocess_page(&$vars) {
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
        $vars['theme_hook_suggestions'][] = 'page__two_col_left_main';
        break;
      default:
        break;
    }
  }
} */

/**
 * Implements hook_breadcrumb().
 *
 * This code will remove unwanted elements of the breadcrumbs variable.
 */
function islandora_default_breadcrumb($vars) {
  $islandora_object = menu_get_object('islandora_object', 2);
  $is_collection = (is_object($islandora_object) && (array_search('islandora:collectionCModel', $islandora_object->models) === FALSE));

  //  $item = menu_get_item();
  //  if (is_array($item)) { }
  // dpm($_GET);
  // dpm($_SERVER['REQUEST_URI']);
  // dpm('is_collection = ' . ($is_collection ? 'TRUE' : 'FALSE'));

  if (!empty($vars['breadcrumb'])) {
    $crumbs = array();

    foreach($vars['breadcrumb'] as $idx=>$value) {
      if (strstr($value, 'Islandora Repository') || strstr($value, 'Pitt Collections (Root)')) {
      }
      else {
        // This would prevent a breadcrumb for values like info\:fedora/pitt\:
        if (strstr($value, "info\\:fedora/pitt\\:", $value)) {
          $value = str_replace(">info\\:fedora/", ">", $value);
        }
        $crumbs[] = ''.$value.'';
      }
    }
  }
  return implode(" &raquo; ", $crumbs);
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


function islandora_default_preprocess_islandora_basic_collection_wrapper(&$variables) {
  //dsm($variables, 'vars');
  $islandora_object = (isset($variables['islandora_object']) ? $variables['islandora_object'] : NULL);
  if ($islandora_object) {
    $page_number = (empty($_GET['page'])) ? 0 : $_GET['page'];
    $page_size = (empty($_GET['pagesize'])) ? variable_get('islandora_basic_collection_page_size', '10') : $_GET['pagesize'];
    list($total_count, $results) = islandora_basic_collection_get_member_objects($islandora_object, $page_number, $page_size);
    $variables['total_count'] = $total_count;
    if (isset($islandora_object['TN_LARGE'])) {
      $collection_tn_url = url("islandora/object/{$islandora_object->id}/datastream/TN_LARGE/view");
      $params = array(
        'title' => $islandora_object->label,
        'alt' => $islandora_object->label,
        'path' => $collection_tn_url);
      $variables['collection_img'] = theme('image', $params);
    }
    module_load_include('inc', 'islandora', 'includes/metadata');
    $variables['collection_metadata'] = islandora_retrieve_metadata_markup($variables['islandora_object']);
  }
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
        $variables['metadata_link'] = l(t("Return to item description"), "islandora/object/{$islandora_object->id}");
        break;
      case 'islandora_manuscript_ead_display':
        $variables['xslt_doc'] = $xslt_doc = new DOMDocument();
        $xslt_doc->load(drupal_get_path('theme', 'islandora_default') . '/transforms/ead_to_html.xslt');
        break;
      default:
        break;
    }
  }
}
