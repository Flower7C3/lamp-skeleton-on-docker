<?php

/**
 * Created by PhpStorm.
 * User: bkwiatek
 * Date: 24.08.2016
 * Time: 10:12
 */
class InfoResource extends Resource
{
    private $types = [

    ];

    public function __construct($key, $val)
    {
        if (isset($this->types[$key])) {
            $temp = $this->types[$key];
            $this->setTitle($temp['title'])
                ->setName($temp['name'])
                ->setIcons($temp['icons']);

        } else {
            $this->setTitle($key)
                ->setName($key);
        }

        $this->setValue($val);

        if (preg_match("'ssh'", $key)) {
            $this->setIcons(['terminal']);
            $this->setName(preg_replace("'ssh'", '', $this->getName()));
        }
        if (preg_match("'sql'", $key)) {
            $this->setIcons(['database']);
            $this->setName(preg_replace("'sql'", '', $this->getName()));
        }
        if (preg_match("'event'", $key)) {
            $this->setIcons(['calendar']);
            $this->setName(preg_replace("'event'", '', $this->getName()));
        }
        if (preg_match("'^(PL|EN)'", $key)) {
            $this->setIcons(['flag']);
        }
    }

    /**
     * @var string
     */
    private $value;

    /**
     * @return string
     */
    public function getValue()
    {
        if (preg_match("'pass'", $this->getName())) {
            return '***';
        }
        return $this->value;
    }

    /**
     * @return string
     */
    public function getValueReal()
    {
        return $this->value;
    }

    /**
     * @param string $value
     * @return InfoResource
     */
    public function setValue($value)
    {
        $this->value = $value;
        return $this;
    }

}
