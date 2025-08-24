local Translations = {
    notify = {
        job = 'Bu komutu yalnızca polisler kullanabilir!',
        detail = 'Lütfen bir callsign girin!',
        notfound = 'Bu callsign\'a sahip bir oyuncu bulunamadı!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})