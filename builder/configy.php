<?php
    function write_path($path_arg){
        $handle = fopen("./config.ini", "r+") or die("Error while reading file!");
        $path = 'path = '.$path_arg;
        $overwrite = 0;
        $file_buffer = '';
        if($handle){
            while(($line = fgets($handle)) !== false){
                $output = explode(' ', $line)[0];
                if($output == 'path'){
                    $overwrite = 1;
                    $file_buffer .= $path;
                } else {
                    $file_buffer .= $line;
                }
            }
            if(!$overwrite){
                fwrite($handle, $path);
                fclose($handle);
            } else {
                $file_content = implode($file_buffer);
                fclose($handle);
                $handle = fopen("./config.ini", "w+") or die("Error overwriting file!");
                fwrite($handle, $file_content);
                fclose($handle);
            }
        }
    }
?>
<html>
    <head>
        <title>ＫｅｎＯＳ　コゃ越</title>
        <link rel="stylesheet" type="text/css" href="../css/index.css">
        <meta charset="UTF-8">
    </head>
    <body>
        <div class="wrap">
            <div class="kenify">
                <?php
                    $ini = parse_ini_file('./config.ini');
                    $pass = $ini['pass'];
                    $path = $_POST['path'];
                    $access = $_POST['access'];
                    if($access == $pass){
                        write_path($path);
                        echo 'Configy is done writing path to config file.';
                    } else {
                        echo 'ACCESS DENIED';
                    }
                ?>
            </div>
        </div>
    </body>
</html>