<?php

require_once dirname(__FILE__) . '/vendor/autoload.php';

$serviceFolders = dirname(__FILE__) . '/src/';
$voFolders = array($serviceFolders . '/vo/');

$config = new Amfphp_Core_Config();
$config->serviceFolderPaths = array($serviceFolders);
$config->pluginsConfig['AmfphpVoConverter'] = array('voFolders' => $voFolders);

$gateway = Amfphp_Core_HttpRequestGatewayFactory::createGateway($config);
$gateway->service();
$gateway->output();