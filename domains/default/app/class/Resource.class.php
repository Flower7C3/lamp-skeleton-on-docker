<?php

/**
 * Created by PhpStorm.
 * User: bkwiatek
 * Date: 18.08.2016
 * Time: 20:47
 */
abstract class Resource
{
    /** @var string */
    protected $title = null;

    /** @var string */
    protected $name = null;

    /** @var string */
    protected $url = null;

    /** @var array */
    protected $icons = array();

    /**
     * @return string
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * @param string $title
     * @return Resource
     */
    public function setTitle($title)
    {
        $this->title = trim($title);
        return $this;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param string $name
     * @return Resource
     */
    public function setName($name)
    {
        $this->name = trim($name);
        return $this;
    }

    /**
     * @return string
     */
    public function getUrl()
    {
        return $this->url;
    }

    /**
     * @param string $url
     * @return Resource
     */
    public function setUrl($url)
    {
        $this->url = $url;
        return $this;
    }

    /**
     * @return array
     */
    public function getIcons()
    {
        return $this->icons;
    }

    /**
     * @param array $icons
     * @return Resource
     */
    public function setIcons(array $icons)
    {
        $this->icons = $icons;
        return $this;
    }

    /**
     * @param $icon
     * @return $this
     */
    public function addIcon($icon)
    {
        $this->icons[] = $icon;
        return $this;
    }

    /**
     * @param $icon
     * @return $this
     */
    public function removeIcon($icon)
    {
        if (($key = array_search($icon, $this->icons)) !== false) {
            unset($this->icons[$key]);
        }
        return $this;
    }

    /**
     * @return string
     */
    public function getCode()
    {
        return md5($this->getTitle() . $this->getUrl());
    }

}
