<?php

/**
 * Created by PhpStorm.
 * User: bkwiatek
 * Date: 24.08.2016
 * Time: 10:36
 */
class PathResource extends Resource
{
    private $types = [
        [
            'title' => 'Copy real path',
            'name' => 'Real path',
            'icons' => [
                'folder',
            ],
        ],
        [
            'title' => 'Copy symlink path',
            'name' => 'Symlink path',
            'icons' => [
                'folder-o',
            ],
        ],
        [
            'title' => 'Copy repo path',
            'name' => 'Repo path',
            'icons' => [
                'code-fork',
            ],
        ],
    ];

    function __construct($key, $path)
    {
        if (empty($path)) {
            return null;
        }
        if (isset($this->types[$key])) {
            $temp = $this->types[$key];
            $this->setTitle($temp['title'])
                ->setName($temp['name'])
                ->setIcons($temp['icons']);

        } else {
            $this->setTitle($key)
                ->setName($key);
        }

        $this->setPath($path);
    }

    /**
     * @var string
     */
    private $path;

    /**
     * @return string
     */
    public function getPath()
    {
        return $this->path;
    }

    /**
     * @param string $path
     * @return PathResource
     */
    public function setPath($path)
    {
        $this->path = $path;
        return $this;
    }

}
