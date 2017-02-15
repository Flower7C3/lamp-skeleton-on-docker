<?php

function sluggify($string, $delimiter = '_')
{
//    $string = strtolower(trim(strip_tags($string)));
    $string = str_replace(
        array('ę', 'ó', 'ö', 'ą', 'ś', 'ł', 'ż', 'ź', 'ć', 'ń', 'Ę', 'Ó', 'Ą', 'Ś', 'Ł', 'Ż', 'Ź', 'N'),
        array('e', 'o', 'o', 'a', 's', 'l', 'z', 'z', 'c', 'n', 'E', 'O', 'A', 'S', 'L', 'Z', 'Z', 'N'),
        $string
    );
    $string = strtolower(trim(strip_tags($string)));
    return preg_replace('/[^a-z0-9]/', $delimiter, $string);
}

$name = "Bartłomiej Kwiatek";
var_dump($name, sluggify($name));
$name = "Olgierd Schönwald";
var_dump($name, sluggify($name));
$name = "JOANNA PAŹDZIÓRKO";
var_dump($name, sluggify($name));
