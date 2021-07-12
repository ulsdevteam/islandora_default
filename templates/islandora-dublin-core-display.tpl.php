<?php
/**
* @file
* This is the template file for the object page for large image
*
* Available variables:
* - $islandora_object: The Islandora object rendered in this template file
* - $islandora_dublin_core: The DC datastream object
* - $dc_array: The DC datastream object values as a sanitized array. This
* includes label, value and class name.
* - $islandora_object_label: The sanitized object label.
*
* @see template_preprocess_islandora_dublin_core_display()
* @see theme_islandora_dublin_core_display()

removed from top two line of template:
<fieldset <?php $print ? print('class="islandora islandora-metadata"') : print('class="islandora islandora-metadata collapsible"');?>>
  <legend><span class="fieldset-legend"><?php print t('Details'); ?></span></legend>

also added the <h3> line to the top

removed bottom line also:
</fieldset>

*/
?>
  <h3 class="md_header">Metadata Details</h3>
  <div class="fieldset-wrapper">
    <dl xmlns:dcterms="http://purl.org/dc/terms/" class="islandora-inline-metadata islandora-metadata-fields islandora-object-fields">
      <?php $row_field = 0; ?>
      <?php foreach($dc_array as $key => $value): ?>
        <?php if(isset($value['value']) && !($value['value'] == NULL)): ?>
        <dt property="<?php print $value['dcterms']; ?>" content="<?php print filter_xss(htmlspecialchars($value['value'], ENT_QUOTES, 'UTF-8')); ?>" class="<?php print $value['class']; ?><?php print $row_field == 0 ? ' first' : ''; ?>">
          <?php print filter_xss($value['label']); ?>
        </dt>
        <dd class="<?php print $value['class']; ?><?php print $row_field == 0 ? ' first' : ''; ?>">
          <?php print filter_xss($value['value']); ?>
        </dd>
        <?php endif; ?>
        <?php $row_field++; ?>
      <?php endforeach; ?>
    </dl>
  </div>
