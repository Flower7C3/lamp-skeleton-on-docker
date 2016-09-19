<?php
error_reporting(E_ALL);
ini_set('display_errors', true);

\Locale::setDefault('pl_PL');

$suffix = '\.' . str_replace('.', '\.', $_SERVER['SERVER_NAME']);
$isXip = preg_match("'.xip.io$'", $_SERVER['SERVER_NAME']);
$dir = "/vagrant/domains/";
$itemsPerPage = 10;
$_CLIENTS_META = [
];
$_TAGS_META = [
    'evolution' => (object)[
        'icons' => ['plus-square-o'],
    ],
    'support' => (object)[
        'icons' => ['life-ring'],
    ],
    'webmaster' => (object)[
        'icons' => ['user-secret'],
    ],
    'backend' => (object)[
        'icons' => ['server'],
    ],
    'frontend' => (object)[
        'icons' => ['globe'],
    ],
    'PHP' => (object)[
        'icons' => ['code'],
    ],
    'HTML5' => (object)[
        'icons' => ['html5'],
    ],
    'CSS3' => (object)[
        'icons' => ['css3'],
    ],
    'NPM' => (object)[
        'icons' => ['archive'],
    ],
    'composer' => (object)[
        'icons' => ['archive'],
    ],
    'Grunt' => (object)[
        'icons' => ['cogs'],
    ],
    'GULP' => (object)[
        'icons' => ['cogs'],
    ],
    'Symfony' => (object)[
        'icons' => ['code'],
    ],
    'Wordpress' => (object)[
        'icons' => ['wordpress'],
    ],
    'newsletter' => (object)[
        'icons' => ['envelope'],
    ],
    'mailing' => (object)[
        'icons' => ['envelope'],
    ],
    'events' => (object)[
        'icons' => ['calendar'],
    ],
    'api' => (object)[
        'icons' => ['crosshairs'],
    ],
    'pl' => (object)[
        'icons' => ['flag'],
    ],
    'mobile' => (object)[
        'icons' => ['mobile'],
    ],
];
$filesAsTags = [
    'composer.json' => ['composer', 'backend'],
    'package.json' => ['NPM'],
    'Gruntfile.js' => ['Grunt', 'frontend'],
    'gulpfile.js' => ['GULP', 'frontend'],
    'wp-config.php' => ['Wordpress', 'PHP'],
    'app/appKernel.php' => ['Symfony', 'PHP'],
];
$VHOSTS = [];

$TOOLS_MENU = array(
    'pma' => new ToolResource('pma', 'http://' . $_SERVER['SERVER_NAME'] . '/phpmyadmin/'),
    'phpinfo' => new ToolResource('phpinfo', 'http://' . $_SERVER['SERVER_NAME'] . '/info.php'),
);

/**
 * methods
 */
function generateListLink($href, array $params = null, $icons = null, $text = false, array $textParams = null)
{
    $link = generateLink($href, $params, $icons, $text, $textParams);
    if (empty($link)) {
        return NULL;
    }
    return '<li>' . $link . '</li>';
}

function generateLink($href, array $params = null, $icons = null, $text = false, array $textParams = null)
{
    if (empty($href)) {
        return NULL;
    }

    if ($href instanceof Resource) {
        $resource = $href;
        if ($href instanceof SiteResource || $href instanceof ToolResource) {
            $textParams['append'] = ' <em class="text-muted">' . $resource->getUrl() . '</em>';
        }
        $href = $resource->getUrl();
        $params['title'] = $resource->getTitle();
        $text = $resource->getName();
        $icons = $resource->getIcons();
    }

    if ($href === 'dropdown') {
        $href = 'javascript://undefined';
        $params['data-toggle'] = "dropdown";
        $params['aria-haspopup'] = "true";
        $params['aria-expanded'] = "false";
        $params['class'] .= " dropdown-toggle";
    }
    if (empty($textParams['class'])) {
        $textParams['class'] = '';
    }
    if (empty($textParams['append'])) {
        $textParams['append'] = '';
    }
    $link = '<a';
    $params['href'] = $href;
    foreach ($params as $k => $v) {
        $link .= ' ' . $k . '="' . $v . '"';
    }
    $link .= '>';
    if (!empty($icons)) {
        if (!is_array($icons)) {
            $icons = [$icons];
        }
        foreach ($icons as $icon) {
            $link .= '<em class="fa fa-fw fa-' . $icon . '"></em>';
        }
    }
    $link .= '<span' . (empty($textParams['class']) ? '' : ' class="' . $textParams['class'] . '"') . '>';
    $link .= $text;
    if (!empty($textParams['append'])) {
        $link .= $textParams['append'];
    }
    $link .= '</span>';
    $link .= '</a>';
    return $link;
}
