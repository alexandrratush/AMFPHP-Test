<?php

define('ROOT', dirname(__FILE__) . "/lib/Amfphp/");

require_once ROOT . "/ClassLoader.php";

$serviceFolders = dirname(__FILE__) . '/src/';
$voFolders = array($serviceFolders . '/vo/');

$config = new Amfphp_Core_Config();
$config->serviceFolders = array($serviceFolders);
$config->pluginsConfig['AmfphpVoConverter'] = array('voFolders' => $voFolders);

$gateway = Amfphp_Core_HttpRequestGatewayFactory::createGateway($config);
$gateway->service();
$gateway->output();