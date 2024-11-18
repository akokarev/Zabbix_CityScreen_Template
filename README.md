# Zabbix_CityScreen_Template
Мониторинг показов и camshot в CityScreen.

# Install
Установите Zabbix-agent, если еще не установлен.

### Загрузите скрипт сюда:
```
/usr/lib/zabbix/externalscripts/cs_api_request.sh
```

### Разрешите запуск скрипта:
```
sudo chmod 755 /usr/lib/zabbix/externalscripts/cs_api_request.sh
```

### Добавьте в */etc/zabbix/zabbix_agentd.conf*:
```
UserParameter=cs.api.request[*],/usr/lib/zabbix/externalscripts/cs_api_request.sh $1 $2 $3
```

### Перезагрузите Zabbix-agent:
```
systemctl restart zabbix-agent
```

### Загрузите шаблон CityScreen.yaml в Zabbix.

### Узнайте ваш API token и запишите его в макрос шаблона **{$CS_API_TOKEN}**.
Например, в браузере GoogleChrome переходим в раздел "Статистика", нажимаем <Ctr>+<Shift>+<M>. В появившейся панели на вкладке "Network" ищем строчку:
> impressions?offset=0&amount=250
Если нет такой строки, то выберите любой фрейм.
После выбора строчки перейдите во вкладку "Headers", обычно в самом низу есть параметр "x-auth-token:" это и есть токен.
Сдесь же во вкладке Payload можно увидеть ID выбранных фреймов.

### Создайте для каждого фрейма узел. 
Присоедините шаблон CityScreen.
Добавьте интерфейс Zabbix-agent (например 127.0.0.1, если агент работает на сервере Zabbix).
Добавьте макрос **{$CS_FRAME_ID}**.

### Настройте в шаблоне элементы данных под свои задачи.
У меня camshot'ы делаются в 5:50, в 8:50 и в 12:50 по UTC. По-этому cs_camshots собирается 3 раза в день по расписанию h6,9,13, а триггер закрывается вручную. Вы можете изменить эти параметры как вам необходимо.
