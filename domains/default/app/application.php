<?php


require 'class/Resource.class.php';
require 'class/SiteResource.class.php';
require 'class/ToolResource.class.php';
require 'class/InfoResource.class.php';
require 'class/PathResource.class.php';
require 'config/config.dist.php';
require 'config/config.php';

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
            'liveUrl' => null,
            'date' => null,
            'domains' => [],
            'tools' => [],
            'info' => [],
            'tags' => [],
            'path' => [],
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

        # repo URL
        if (file_exists($symlinkPath . '/.git/config')) {
            $gitConfig = parse_ini_file($symlinkPath . '/.git/config', true);
            if (!empty($gitConfig['remote origin']['url'])) {
                $data['path'][] = new PathResource('repo', $gitConfig['remote origin']['url']);
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
                /*
                 * domains
                 */
                if (!isset($data['domains']['local'])) {
                    $config['domains']['local'] = $data['url'];
                }
                if (preg_match("'\.'", $externalDomain)) {
                    if (!isset($config['domains']['live'])) {
                        $config['domains']['live'] = 'http://' . $externalDomain;
                    }
                }
                if (isset($config['domains'])) {
                    $data['domains'] = array();
                    foreach ($config['domains'] as $key => $url) {
                        if (!empty($url)) {
                            $data['domains'][$key] = new SiteResource($key, $url);
                        }
                    }
                }
                /*
                 * tools
                 */
                if (!isset($config['tools']['repo']) && isset($data['repoUrl'])) {
                    $config['tools']['repo'] = $data['repoUrl'];
                    unset($data['repoUrl']);
                }
                if (!empty($config['tools'])) {
                    $data['tools'] = $config['tools'];
                    foreach ($config['tools'] as $key => $url) {
                        if (!empty($url)) {
                            $data['tools'][$key] = new ToolResource($key, $url);
                        }
                    }
                    ksort($data['tools']);
                }
                /*
                 * info
                 */
                if (!empty($config['info'])) {
                    foreach ($config['info'] as $key => $val) {
                        $data['info'][$key] = new InfoResource($key, $val);
                    }
                }
                /*
                 * note
                 */
                if (!empty($config['note'])) {
                    krsort($config['note']);
                    $data['note'] = $config['note'];
                }
                /*
                 * tags and info
                 */
                if (isset($config['client_id'])) {
                    $data['client_id'] = $config['client_id'];
                }
                if (isset($config['job_id'])) {
                    $data['job_id'] = $config['job_id'];
                }
                if (isset($config['code'])) {
                    $data['code'] = $config['code'];
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

        $data['path'][] = new PathResource('real', $realPath);
        $data['path'][] = new PathResource('link', $symlinkPath);

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
