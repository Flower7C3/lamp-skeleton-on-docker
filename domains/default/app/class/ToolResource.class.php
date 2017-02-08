<?php

/**
 * Created by PhpStorm.
 * User: bkwiatek
 * Date: 18.08.2016
 * Time: 21:03
 */
class ToolResource extends Resource
{
    private $types = [
        'repo' => [
            'icons' => ['code-fork'],
            'title' => 'Repository manager',
            'name' => 'GIT',
        ],
        'pma' => [
            'icons' => ['database'],
            'title' => 'Database manager',
            'name' => 'SQL',
        ],
        'crm' => [
            'icons' => ['user-secret'],
            'title' => 'CRM project',
            'name' => 'CRM',
        ],
        'task' => [
            'icons' => ['tasks'],
            'title' => 'Redmine project',
            'name' => 'Redmine',
        ],
        'wiki' => [
            'icons' => ['wikipedia'],
            'title' => 'Wiki info',
            'name' => 'wiki',
        ],
        'info' => [
            'icons' => ['info-circle'],
            'title' => 'Info site',
            'name' => 'info',
        ],
        'phpinfo' => [
            'icons' => ['microchip'],
            'title' => 'PHP info',
            'name' => 'phpinfo',
        ],
        'support' => [
            'icons' => ['life-ring'],
            'title' => 'Support site',
            'name' => 'support',
        ],
        'event' => [
            'icons' => ['calendar'],
            'title' => 'Support site',
            'name' => 'support',
        ],
        'CMS' => [
            'icons' => ['pencil-square'],
            'title' => 'CMS site',
            'name' => 'CMS',
        ],
    ];

    public function __construct($key, $url)
    {
        if (!empty($url)) {
            if (isset($this->types[$key])) {
                $temp = $this->types[$key];
                $this->setTitle($temp['title'])
                    ->setName($temp['name'])
                    ->setIcons($temp['icons']);

            } else {
                $this->setTitle($key)
                    ->setName($key);
            }
            if (preg_match("'event'", $key)) {
                $this->addIcon('calendar');
                $this->setName(preg_replace("'event'", '', $this->getName()));
            }
            if (preg_match("'^(PL|EN)'", $key)) {
                $this->addIcon('flag');
            }
            if (preg_match("'pay'", $key)) {
                $this->addIcon('money');
            }
            if (preg_match("'skin'", $key)) {
                $this->addIcon('eye');
            }
            if (preg_match("'link'", $key)) {
                $this->addIcon('link');
            }
            $this->setUrl($url);
        }
    }
}
