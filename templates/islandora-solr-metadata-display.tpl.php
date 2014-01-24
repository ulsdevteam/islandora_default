<?php
/**
 * @file
 * Islandora_solr_metadata display template.
 *
 * Variables available:
 * - $solr_fields: Array of results returned from Solr for the current object
 *   based upon defined display configuration(s). The array structure is:
 *   - display_label: The defined display label corresponding to the Solr field
 *     as defined in the configuration in translatable string form.
 *   - value: An array containing all the result(s) found for the specific field
 *     in Solr for the current object when queried against Solr.
 * 
 * @see template_preprocess_islandora_solr_metadata_display()
 */
?>

<fieldset <?php $print ? print('class="islandora islandora-metadata"') : print('class="islandora islandora-metadata"');?>>
  <legend><span class="fieldset-legend">
  </span></legend>
  <div class="fieldset-wrapper">
    <ul xmlns:dcterms="http://purl.org/dc/terms/" class="islandora-inline-metadata islandora-metadata-fields">
      <?php $row_field = 0; ?>
      <?php foreach($solr_fields as $value): ?>
      <li class="metadata-label"> <?php print $value['display_label']; ?> </li>
      <li class="metadata-field"> <?php print implode('<br/>', $value['value']); ?> </li>
      <?php $row_field++; ?>
      <?php endforeach; ?>
    </ul>
  </div>
</fieldset>
