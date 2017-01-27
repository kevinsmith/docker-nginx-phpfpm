<html>
<head>
    <title>Hello world!</title>
    <link href='//fonts.googleapis.com/css?family=Lato:400,900' rel='stylesheet'>
    <style>
    body {
        background-color: white;
        text-align: center;
        padding: 50px;
        font-family: 'Lato',sans-serif;
    }
    h1 {
        margin-top: 50px;
    }
    </style>
</head>
<body>
    <h1><?php echo "Hello ".($_ENV["NAME"]?$_ENV["NAME"]:"world")."!"; ?></h1>
    <?php if($_ENV["HOSTNAME"]): ?>
        <p>This container's hostname is <code><?php echo $_ENV["HOSTNAME"]; ?></code></p><br>
    <?php endif; ?>
    <?php
    $envs = [];
    foreach($_ENV as $key => $value) {
        if(preg_match("/^(NGINX_.+)$/", $key, $matches)) {
            $envs[] = [
                'name' => $matches[1],
                'value' => $value
            ];
        }
    }
    if($envs) {
        usort($envs, function($a, $b) {
            return strcmp($a['name'], $b['name']);
        });
    ?>
        <h3>nginx Configuration:</h3>
        <?php
        foreach($envs as $env) {
            ?>
            <b><?php echo $env["name"]; ?></b>: <code><?php echo $env["value"]; ?></code><br>
            <?php
        }
        ?>
    <?php
    }
    ?>
</body>
</html>
