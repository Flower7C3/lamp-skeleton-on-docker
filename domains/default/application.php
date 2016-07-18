<?php


require 'config.dist.php';
require 'config.php';

/**
 * versions
 */
$bootstrapVersion = '3.3.4';
$fontawesomeVersion = '4.6.3';
$jqueryVersion = '2.1.4';

/**
 * read directories
 */
$idf = new \IntlDateFormatter(\Locale::getDefault(), \IntlDateFormatter::SHORT, \IntlDateFormatter::SHORT);
$dh = opendir($dir);
$filenames = [];
$CLIENTS = [];
$TAGS = [];
$DOMAINS = [];
$HOSTS = [];
$title = isset($_VHOSTS_META[$currentVhost]->name) ? $_VHOSTS_META[$currentVhost]->name : 'vServer@' . $currentVhost;

while (false !== ($filename = readdir($dh))) {

    if (
        preg_match("'" . $suffix . "$'", $filename)
        && (
            (!isset($_GET['project'])) ||
            (isset($_GET['project']) && stripslashes($_GET['project'] . $suffix) == $filename)
        )
    ) {

        $data = [
            'code' => null,
            'name' => null,
            'url' => null,
            'devUrl' => null,
            'stageUrl' => null,
            'liveUrl' => null,
            'repoUrl' => null,
            'date' => null,
            'tools' => [],
            'tags' => [],
        ];

        # domain and paths
        $localDomain = $filename;
        $externalDomain = preg_replace("'" . $suffix . "'", '', $filename);
        $symlinkPath = $dir . $filename;
        $realPath = realpath($dir . (is_link($symlinkPath) ? readlink($symlinkPath) : $symlinkPath));
        if (file_exists($symlinkPath . '/web/app_dev.php')) {
            $baseurl = '/app_dev.php';
        } elseif (file_exists($symlinkPath . '/web/wp-config.php')) {
            $baseurl = ':81';
        } elseif (file_exists($symlinkPath . '/build/production/')) {
            $baseurl = ':82';
        } elseif (file_exists($symlinkPath . '/web/')) {
            $baseurl = '/';
        } else {
            $baseurl = ':81';
        }

        # last modification time from repo
        $mtime = file_exists($symlinkPath . '/.git/') ? filemtime($symlinkPath . '/.git/') : (file_exists($symlinkPath) ? filemtime($symlinkPath) : 0);

        # meta data
        $data['name'] = $externalDomain;
        $data['code'] = basename(dirname($realPath));
        $data['client_id'] = preg_match("'^([0-9]{3})_(.*)$'", $data['code']) ? preg_replace("'^([0-9]{3})_(.*)$'", "$1.", $data['code']) : null;
        $data['job_id'] = preg_match("'^([0-9]{3})_([0-9]{3})_(.*)$'", $data['code']) ? preg_replace("'^([0-9]{3})_([0-9]{3})_(.*)$'", "$1.$2", $data['code']) : null;
        $data['date'] = new \DateTime('@' . $mtime);
        $data['current'] = ($data['date']->diff(new \DateTime())->days > 7) ? false : true;

        # local and live URLs
        $data['url'] = 'http://' . $localDomain . $baseurl;
        if (preg_match("'\.'", $externalDomain)) {
            $data['liveUrl'] = 'http://' . $externalDomain;
        }

        # repo URL
        if (file_exists($symlinkPath . '/.git/config')) {
            $gitConfig = parse_ini_file($symlinkPath . '/.git/config', true);
            if (!empty($gitConfig['remote origin']['url'])) {
                $data['path']['repo'] = $gitConfig['remote origin']['url'];
                $data['repoUrl'] = preg_replace("'^git@(.*):(.*)\.git$'", "https://$1/$2", $gitConfig['remote origin']['url']);
            }
            foreach ($gitConfig as $gName => $gData) {
                if (preg_match("'^branch (.*)$'", $gName)) {
                    $data['branches'][] = preg_replace("'^branch (.*)$'", "$1", $gName);
                }
            }
        }

        # data from description file
        $descriptionFiles = [
            $symlinkPath . '/DESCRIPTION',
            $symlinkPath . '/DESCRIPTION.ini',
            dirname($realPath) . '/DESCRIPTION',
            dirname($realPath) . '/DESCRIPTION.ini',
            dirname($realPath) . '/DESCRIPTION-' . $externalDomain,
            dirname($realPath) . '/DESCRIPTION-' . $externalDomain . '.ini',
        ];
        foreach ($descriptionFiles as $descriptionFile) {
            if (file_exists($descriptionFile)) {
                $config = parse_ini_file($descriptionFile, true);
                if (isset($config['domains']['local'])) {
                    $data['url'] = $config['domains']['local'];
                }
                if (isset($config['domains']['dev'])) {
                    $data['devUrl'] = $config['domains']['dev'];
                }
                if (isset($config['domains']['stage'])) {
                    $data['stageUrl'] = $config['domains']['stage'];
                }
                if (isset($config['domains']['prod'])) {
                    $data['liveUrl'] = $config['domains']['prod'];
                }
                if (isset($config['tools']['repo'])) {
                    $data['repoUrl'] = $config['tools']['repo'];
                    unset($config['tools']['repo']);
                }
                if (isset($config['client_id'])) {
                    $data['client_id'] = $config['client_id'];
                }
                if (isset($config['job_id'])) {
                    $data['job_id'] = $config['job_id'];
                }
                if (isset($config['code'])) {
                    $data['code'] = $config['code'];
                }
                if (!empty($config['tools'])) {
                    foreach ($config['tools'] as $key => $url) {
                        $data['tools'][$key] = toolMenu($key, $url);
                    }
                    ksort($data['tools']);
                }
                if (!empty($config['info'])) {
                    foreach ($config['info'] as $key => $val) {
                        $data['info'][$key] = infoMenu($key, $val);
                    }
                }
                if (!empty($config['note'])) {
                    krsort($config['note']);
                    $data['note'] = $config['note'];
                }
                if (!empty($config['tags'])) {
                    $data['tags'] = explode(',', $config['tags']);
                }
            }
        }

        foreach ($filesAsTags as $file => $tags) {
            if (file_exists($symlinkPath . '/' . $file)) {
                $data['tags'] = array_merge($data['tags'], $tags);
            }
        }

        $data['tags'] = array_unique($data['tags']);
        natcasesort($data['tags']);
        foreach ($data['tags'] as $t) {
            $TAGS[$t] = $t;
        }

        $data['path']['real'] = $realPath;
        $data['path']['link'] = $symlinkPath;

        $CLIENTS[$data['client_id']] = $data['client_id'];

        $DOMAINS[] = (object)$data;

        $HOSTS[] = $localDomain;
    }
}

sort($HOSTS);

$CLIENTS = array_unique($CLIENTS);
natcasesort($CLIENTS);

$TAGS = array_unique($TAGS);
natcasesort($TAGS);
