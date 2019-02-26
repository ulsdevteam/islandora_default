<?php
//test change

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

function islandora_default_preprocess_islandora_newspaper_page(&$variables) {
}

function islandora_default_preprocess_islandora_newspaper_issue(&$variables) {
  $variables['object_link'] = l('Go to item description', '/islandora/object/' . $variables['object']->id);
}

// This can be altered here to add a thumbnail for each issue.
function islandora_default_preprocess_islandora_newspaper(&$variables) {
  if (isset($variables['islandora_content_render_array']['tabs'])) {
    foreach ($variables['islandora_content_render_array']['tabs'] as $tabkey_year => $year_tab_array) {
      if ($tabkey_year <> '#type') {
        foreach ($variables['islandora_content_render_array']['tabs'][$tabkey_year] as $tabkey_month => $month_tab_array) {
          if ($tabkey_month <> '#type' && $tabkey_month <> '#title' && is_array($variables['islandora_content_render_array']['tabs'][$tabkey_year][$tabkey_month])) {
            foreach ($variables['islandora_content_render_array']['tabs'][$tabkey_year][$tabkey_month] as $tabkey_day => $day_tab_array) {
              if ($tabkey_day <> '#attributes' && $tabkey_day <> '#title' && $tabkey_day <> '#type') {
                foreach ($variables['islandora_content_render_array']['tabs'][$tabkey_year][$tabkey_month][$tabkey_day] as $tabkey_issue_idx => $day_issue_tab_array) {
                  if (isset($day_issue_tab_array['#suffix'])) {
                    $variables['islandora_content_render_array']['tabs'][$tabkey_year][$tabkey_month][$tabkey_day][$tabkey_issue_idx]['#suffix'] = 
                      '<br><a href="/' . $day_issue_tab_array['#path'] . '"><img class="newspaper-tiny-thumb" src="/' . str_replace('/viewer', '', $day_issue_tab_array['#path']) . '/datastream/TN/view" width="48"></a></div>';
                  }
                }
              }
            }
          }
        }
      }
    }
    $variables['islandora_content_copy'] = drupal_render($variables['islandora_content_render_array']);
  }
  else {
    $variables['islandora_content_copy'] = $variables['islandora_content'];
  }
}

function islandora_default_preprocess_islandora_pdf(&$variables) {
  $islandora_object = (isset($variables['islandora_object']) ? $variables['islandora_object'] : NULL);
  // PDF instead of OBJ if possible
  if (isset($islandora_object['PDF'])) {
    $variables['islandora_content'] = l( (isset($variables['islandora_preview_img']) ? 
        $variables['islandora_preview_img'] : 
        (isset($islandora_object['TN_LARGE']) ? '<img src="/islandora/object/' . $islandora_object->id . '/datastream/TN_LARGE/view" alt="' . htmlspecialchars($islandora_object->label) . '">' : 'preview missing')), 
      url("islandora/object/{$islandora_object->id}/datastream/PDF/view", array('absolute' => TRUE)), array('html' => TRUE));
  }
}

function islandora_default_breadcrumb($variables) {
  // need the _format_collection_url() function 
  module_load_include('module', 'upitt_islandora_solr_search_extras');

  $breadcrumb = $variables['breadcrumb'];

  if (!empty($breadcrumb)) {
    $crumbs = array();
    $item = menu_get_item();
    foreach($breadcrumb as $value) {
      if (strstr($value, 'Pitt Collections (Root)') || strstr($value, 'Islandora Repository') || 
        (strip_tags($value) == '...') ||
        strstr($value, 'RELS_EXT_isViewableByRole_literal_ms:') || strstr($value, 'PID:(pitt*)') ||
        strstr($value, '>pitt*<') ) {
      }
      elseif (strstr($value, ':collection.') && (($item['path'] == 'islandora/search_collection/%/%') || ($item['path'] == 'islandora/search_collection/%'))) {
      }
      else {
        // Get the href from the breadcrumb and look for a colon -- if that splits to a PID that is a 
        // Collection object, then rewrite the URL for the breadcrumb.
        preg_match('/^<a.*?href=(["\'])(.*?)\1.*$/', $value, $m);
        if (count($m) > 1) {
          $url = urldecode($m[2]);
          $pid_tmp = str_replace('/islandora/object/', '', $url);
          @list($pid_tmp, $junk) = explode("?", $pid_tmp);
          @list($pid, $junk) = explode("/", $pid_tmp);
          $collection_object = islandora_object_load($pid);
          if (is_object($collection_object) && strstr($url, ':collection.') && strstr($url, '/islandora/object/')) {
            // Set attributes variable.
            $attr = array(
              'title' => strip_tags($value),
              'rel' => 'nofollow',
              'href' => '/' . _format_collection_url($collection_object->label, true),
            );
            $value = '<a' . drupal_attributes($attr) . '>' . $attr['title'] . '</a>';
          }
        }
        $crumbs[] = ''.$value.'';
      }
    }
    return implode(" &raquo; ", $crumbs);
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


function islandora_default_preprocess_islandora_basic_collection_wrapper(&$variables) {
  //dsm($variables, 'vars');
  $islandora_object = (isset($variables['islandora_object']) ? $variables['islandora_object'] : NULL);
  if ($islandora_object) {
    $page_number = (empty($_GET['page'])) ? 0 : $_GET['page'];
    $page_size = (empty($_GET['pagesize'])) ? variable_get('islandora_basic_collection_page_size', '10') : $_GET['pagesize'];
    list($total_count, $results) = islandora_basic_collection_get_member_objects($islandora_object, $page_number, $page_size);
    $variables['total_count'] = $total_count;

    $collection_tn_url = '';
    if (isset($islandora_object['TN_LARGE'])) {
      $collection_tn_url = url("islandora/object/{$islandora_object->id}/datastream/TN_LARGE/view");
    } elseif (isset($islandora_object['TN'])) {
      $collection_tn_url = url("islandora/object/{$islandora_object->id}/datastream/TN/view");
    }
    $params = array(
      'title' => $islandora_object->label,
      'alt' => $islandora_object->label,
      'path' => $collection_tn_url);
    $variables['collection_img'] = ($collection_tn_url) ? theme('image', $params) : '';

    module_load_include('inc', 'islandora', 'includes/metadata');
    $variables['collection_metadata'] = islandora_retrieve_metadata_markup($variables['islandora_object']);
  }
}


function islandora_default_preprocess_islandora_newspaper_page_controls(&$variables) {
  if (isset($variables['controls']) && isset($variables['controls']['tiff_download'])) {
    unset($variables['controls']['tiff_download']);
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
      case 'islandora_newspaper_issue':
      case 'islandora_video':
        $variables['metadata_link'] = l(t("Go to item description"), "islandora/object/{$islandora_object->id}");
        if (array_key_exists('parent_collections', $variables) && is_array($variables['parent_collections']) && count($variables['parent_collections'])) {
          $site = islandora_default_get_site_from_config();
          $tmp_parent_collections = $variables['parent_collections'];
          foreach ($tmp_parent_collections as $k => $collection_object) { 
            $keep_this_collection = FALSE;
            $this_parent_object_sites_rel = $collection_object->relationships->get(NULL, 'isMemberOfSite');
            foreach ($this_parent_object_sites_rel as $obj) {
              if (!$keep_this_collection && isset($obj['object']['value']) && $obj['object']['value'] == $site) {
                $keep_this_collection = TRUE;
              }
            }
            if (!$keep_this_collection) {
              unset($variables['parent_collections'][$k]);
            }
          }
        }
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

/**
 * Helper function to derive the site value from the islandora_solr_base_filter value.  Does not handle more than
 * one site value in the base filter.
 */
function islandora_default_get_site_from_config() {
  $base_filter = variable_get('islandora_solr_base_filter');
  // look for the value for RELS_EXT_isMemberOfSite_uri_ms
  $and_filters = explode(" AND ", $base_filter);
  $final_filters = array();
  foreach ($and_filters as $exploded) {
    $nl_exploded = explode("\r\n", $exploded);
    if (is_array($nl_exploded)) {
      foreach ($nl_exploded as $nl_element) {
        $final_filters[] = trim($nl_element);
      }
    }
    else {
      $final_filters[] = $nl_exploded;
    }
  }
  $found_filter = '';
  foreach ($final_filters as $filter) {
    if (strstr($filter, 'RELS_EXT_isMemberOfSite_uri_ms') <> '') {
      $found_filter = $filter;
    }
  }
  if ($found_filter) {
    $site = stripslashes(str_replace(array('"', 'RELS_EXT_isMemberOfSite_uri_ms:'), '', $found_filter));
    return str_replace("info:fedora/", "", $site);
  }
}


/**
 * Implements hook_preprocess_theme().
 *
 */
function islandora_default_preprocess_page(&$vars) {
  // Load webtrends analytics for anonymous users for all pages using this theme
  if (!user_is_logged_in()) { drupal_add_js('//pitt.edu/webtrends/webtrends.load.js', 'external'); };
}

