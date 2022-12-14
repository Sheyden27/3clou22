<html>
<head><title>Mon appli PHP</title>

<body>

<h1>Une application déployée sur le Cloud</h1>

<p>
<?php

  echo "Nom du serveur ", gethostname();
  echo "<br/>";
  echo "Nous sommes le ", date("d M Y h:i:s");

?>
</p>

</body>
