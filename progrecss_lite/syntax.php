<?php
 
/**
 * Progrecss Plugin: Prints CSS-based progress bars
 * 
 * @file       progrecss/syntax.php
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Luis Machuca B. <luis.machuca [at] gulix.cl> modified by eeemsi
 * @brief      Progress bars using CSS.
 * @version    based on 1.6 (Feb 2010)
 *
 */
 
 
if(!defined('DW_LF')) define('DW_LF',"\n");
 
if(!defined('DOKU_INC')) 
define('DOKU_INC',realpath(dirname(__FILE__).'/../../').'/');
if(!defined('DOKU_PLUGIN')) 
define('DOKU_PLUGIN',DOKU_INC.'lib/plugins/');
require_once(DOKU_PLUGIN.'syntax.php');
 
/**
 * All DokuWiki plugins to extend the parser/rendering mechanism
 * need to inherit from this class
 */
class syntax_plugin_progrecss extends DokuWiki_Syntax_Plugin {
 
    /**
     * return some info
     */
    function getInfo(){
        return array(
            'author' => 'Luis Machuca Bezzaza',
            'email'  => 'luis.machuca[at]gulix.cl',
            'date'   => '08/02/2010',
            'name'   => 'Progrecss Plugin',
            'desc'   => 'Prints CSS-based progress bars with <progrecss x% /> or <progrecss x/y />',
            'url'    => 'http://www.dokuwiki.org/plugin:progrecss',
        );
    }
 
    /**
     * What kind of syntax are we?
     */
    function getType(){
        return 'formatting';
    }
 
    /**
     * What can we Do?
     */
    function getAllowedTypes() { 
        return array('substition', 'formatting', 'disabled'); 
    }
 
    /**
     * Where to sort in?
     */
    function getSort(){
        return 550;
    }
 
    /**
     * What's our code layout?
     */    
    function getPType(){ 
        return 'normal'; 
    }
 
    /**
     * How do we get to the lexer?
     */
    function connectTo($mode) {
         $p_param= ".*?";
         $this->Lexer->addSpecialPattern (
                "<progrecss (?:[0-9]{1,2}|100)% $p_param/>", 
                $mode, 'plugin_progrecss');
         $this->Lexer->addSpecialPattern (
                "<progrecss (?:\d+/\d+) $p_param/>", 
                $mode, 'plugin_progrecss');
 
    }
 
    /**
     * Handle the match
     */
    function handle($match, $state, $pos, &$handler){
 
        /* The syntax is expected as follows:
          ppp% [param1=value1; [param2=value2; [...]]] 
         */
        $data= array();
		static $progrecss_count= 0;
        $expected_params= array(
          "caption", // the progrecss bar item caption
          /* caption: can contain formatting wikitext, or be empty. */
          "style",   // the CSS style used, as in 'progrecss_<stylename>'
          /* style: must be empty or a value defined as a user style. */
          "width",   // the CSS width value for the block
          /* width: must be a valid CSS expression for width, except in pt. */
          "order",   // the position of the percentage value
          /* order: before, inside (default) or after */
          "marker",  // --- reserved for future use ---
          "pdisplay" // whether the % is actually displayed (defaults to true)

          );
        /* OK, so let's strip the markup, taking first the precentage%
           value which is _mandatory_. */
        $match = substr($match,11,-2); // Strip markup
        $match= explode(' ', $match, 2);
        $p= $match[0];
        /* If 'p' is of the form 'x/y', convert it to an approximate percentage
        */
        if (preg_match('/\d+\/\d+/', $p) ) {
          $plist= explode('/', $p, 2);
          // if fraction is too large, we just consider it 100%
          $p[0] = min($p[0], $p[1]);
          $p    = intval($plist[0]*100/$plist[1]).'%';
          }
        $data['p']= $p;

        /* That already done, let's split all other elements, which are 
           expected to be in the 'param=value;' format. We must 
           take into consideration 'escaped' semicolons. */
        $elems= preg_split('/(?<!\\\\);/', $match[1]); 

        //$elems= explode(';',$match[1]);

        foreach ($elems as $pair) {
           list($key,$value)= explode('=', $pair, 2);
           trim($key); trim($value);
           /* we check if the param is valid (exists in 'expected_params'), 
              otherwise we just choose to ignore it.
              (yes, something better could've been done) */
           if  (in_array($key, $expected_params) ) { //accept parameter
              $data[$key]= $value;
           } else { //refuse parameter
           }
        }

        /* Sanitize the 'order' parameter */
        if (!preg_match('/(before|after|inside)/', $data['order'] ) ) 
          $data['order'] = 'inside';

        /* At this point, if any of the available parameters was 
           not found, let's apply some sane default. */
        if (empty($data['caption']) )   $data['caption']= "";
        if (empty($data['style'])   )   $data['style']= "default";
        if (empty($data['width'])   )   $data['width']= "100px";
        if (empty($data['pdisplay']))   $data['pdisplay']= true;
 
        $data['style']= "progrecss_". $data['style'];
 
        /* In order to somewhat uniquely IDfy each p-bar, 
           let's use a counter...
           Why didn't I think of that before? */
        $IDnum= sprintf("progrecss_id_%03d", 
                $progrecss_count);
        /* Did I mention that this generates correlative IDs */
 
        $data['id']= $IDnum;
		$progrecss_count= $progrecss_count+1;
 
        /* Are we ready yet? */
        return $data;
 
    }  
 
    /**
     * Create output
     */
    function render($mode, &$renderer, $data) {
      static $counter= 0;
      $percentage=  $data['p'];
      $id= $data['id'];
      $fullwidth=   $data['width'];
      $caption= $data['caption'];
      $style= $data['style']; 

      if($mode == 'xhtml'){
        /* each progrecssbar is enclosed in a DIV of its own, 
           classed according to "style" parameter,
           and IDed in a somewhat-unique manner using both caption
           and random binary toughts. */
        $renderer->doc .= $this->_create_block_header(
                          $id, $style, $fullwidth); 
        $renderer->doc .= '<span class="border" style="width: '. 
                          $fullwidth. ';">';
        /* The next 2-liner contains the actual "intelligence" behind 
           the plugin. The rest is simply "ability".*/
        $renderer->doc .= '  <span class="bar" style="width: '. 
                          $percentage. ';">';
        $renderer->doc .= $percentage. '</span>'. DW_LF;
        /* See? A PHP+CSS is as powerful as... */
        $renderer->doc .= '&nbsp;</span>'. DW_LF;
        $renderer->doc .= $this->_render_caption($caption);
        $renderer->doc .= $this->_create_block_footer($id);
        return true;
      }
      if($mode == 'text'){
        // simply output the percentage in a text renderer
        $renderer->doc .= ' ['. $percentage;
        if (!empty ($caption) ) {
          $renderer->doc .= ' | '. $caption;
          }
        $renderer->doc.= ' ]'. DW_LF;
        return true;
      } // done with the text renderer
      return false;
    }
 
    /*
     * From this point on, all are local functions 
     */

    function _create_block_header($id, $style, $fullwidth) {
      $wt  = DW_LF. '<!-- begin: progrecss bar \''. $id. '\'. -->'. DW_LF;
      $wt  = '<span id="'. $id. '" class="'. $style. '" >'; 
      return $wt;
    }

    function _create_block_footer($id) {
      $wt  = '</span>';
      $wt .= DW_LF. '<!-- end of progrecss bar \''. $id. '\'. -->'. DW_LF;
      return $wt;
    }

    function _render_caption($caption) {
      $wt  = '  <span class="caption">';
      $wt .= p_render('xhtml', p_get_instructions($caption), $info);
      $wt  = str_replace('<p>', '', $wt);
      $wt  = str_replace('</p>', '', $wt);
      $wt  = trim($wt);
      $wt .= '</span>';
      return $wt;
    }

}
 

