# Поддержка форка Pi Web

Этот репозиторий — персональный форк [`agegr/pi-web`](https://github.com/agegr/pi-web).
В `main` поддерживается совместимая с upstream версия, а собственные изменения
вносятся маленькими тематическими коммитами и pull request'ами.

## Первичная разработка

```powershell
cd $HOME\Source\pi-web-ru
npm ci --ignore-scripts
npm run dev
```

Не редактируйте `.next/` и глобальную npm-установку `@agegr/pi-web`: это
собранные артефакты, которые будут перезаписаны обновлением.

## Внесение изменения

```powershell
git switch main
git pull --ff-only origin main
git switch -c feature/<короткое-имя>
# правки
git add <файлы>
git commit -m "feat: <краткое описание>"
git push -u origin HEAD
gh pr create --fill
```

Для перевода используйте отдельные языковые пакеты в `lib/i18n/messages/` и
стабильные ключи интерфейса. Не заменяйте английские строки непосредственно в
компонентах. См. `docs/i18n.md`.

## Обновление с upstream

Перед обновлением убедитесь, что рабочее дерево чистое:

```powershell
cd $HOME\Source\pi-web-ru
git status --short --branch
git fetch upstream --tags
git switch main
git merge --ff-only origin/main
git merge upstream/main
```

Если возникнут конфликты, разрешайте их только после просмотра изменений
upstream и сохраняйте собственные доработки отдельными коммитами. Затем
прогоните проверки:

```powershell
node_modules/.bin/tsc --noEmit
npm run lint
npm test
```

После успешной проверки:

```powershell
git push origin main
```

## Локальный запуск своей версии

Для разработки используйте `npm run dev`. Production-сборку создавайте только
для релиза или отдельного локального развёртывания, потому что `next build`
меняет `.next/`.

Перед заменой глобальной версии Pi Web проверяйте новую сборку в отдельном
каталоге и сохраняйте предыдущую рабочую версию как fallback.
