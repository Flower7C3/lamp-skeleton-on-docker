<?php

/**
 * Created by PhpStorm.
 * User: bkwiatek
 * Date: 18.08.2016
 * Time: 20:49
 */
class SiteResource extends Resource
{
    private $type = [
        'local' => [
            'title' => "Local development page",
            'name' => 'Local',
            'icons' => ['code'],
        ],
        'dev' => [
            'title' => "Development page (dev)",
            'name' => 'Development',
            'icons' => ['globe'],
        ],
        'stage' => [
            'title' => "Development page (stage)",
            'name' => 'Staging',
            'icons' => ['globe'],
        ],
        'master' => [
            'title' => "Production master)",
            'name' => 'Production (master)',
            'icons' => ['industry'],
        ],
        'prod' => [
            'title' => "Production page (prod)",
            'name' => 'Production (prod)',
            'icons' => ['industry'],
        ],
        'live' => [
            'title' => "Production page (live)",
            'name' => 'Production (live)',
            'icons' => ['industry'],
        ],
    ];

    function __construct($key, $url)
    {
        if (empty($url)) {
            return null;
        }
        if (isset($this->type[$key])) {
            $temp = $this->type[$key];
            $this->setTitle($temp['title'])
                ->setName($temp['name'])
                ->setIcons($temp['icons']);

        } else {
            $this->setTitle($key)
                ->setName($key)
                ->addIcon('globe');
        }
        $this->setUrl($url);
    }

}
