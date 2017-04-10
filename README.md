# Docker backup-gem

Utiliza [Backup Gem](http://backup.github.io/backup/) sobre docker con cron (Y [whenever](https://github.com/javan/whenever) para generar el crontab) para respaldar bases de datos en distintos tipos de storages.

## Uso de la imagen

~~~
docker run -d -v $PWD:/root/Backup -v $PWD/.ssh:/root/.ssh pperez/backup-gem:1.0.0
~~~

## Volúmenes

* ```/root/Backup```: Contiene las configuraciones de modelos de [Backup Gem](http://backup.github.io/backup/), también contiene la configuración de repeticiones con [whenever](https://github.com/javan/whenever).
* ```/root/.ssh```: Contiene las llaves ssh utilizadas por los storages SFTP o Rsync via SSH.

## Creacion de modelos (Descripción de backups)

Podemos invocar el contenedor con el comando ```backup generate:model```, ej:

~~~
docker run -it --rm -v $PWD:/root/Backup -v $PWD/.ssh:/root/.ssh pperez/backup-gem:1.0.0 backup generate:model -t rob_redis --storages='sftp' --databases='redis' --compressor='gzip' --notifiers='mail'
~~~

Para más información de las opciones del generador, consultar la sección [Generators](http://backup.github.io/backup/v4/generator/) de Backup gem.

## Creacion de crontab

Para esta tarea se utiliza [whenever](https://github.com/javan/whenever), configurando el fichero ```config/schedule.rb```, este ya debería existir (luego de haber ejecutado el contenedor al menos una vez) y se escribe con la _DSL_ descrita en el repositorio de whenever.
Al iniciar el contenedor leerá este fichero y generará el crontab acorde.
Se puede encontrar más información en la sección [Scheduling Backups](http://backup.github.io/backup/v4/scheduling-backups/) de Backup gem.
