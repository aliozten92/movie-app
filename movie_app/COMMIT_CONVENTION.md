# Commit Mesaj Kuralları

Bu dosya, projedeki commit mesajlarının nasıl yazılması gerektiğini açıklar.

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

## Commit Tipleri

- `feat`: Yeni bir özellik
- `fix`: Bir hata düzeltmesi
- `docs`: Sadece dokümantasyon değişiklikleri
- `style`: Kodun çalışmasını etkilemeyen değişiklikler (boşluk, format, vb.)
- `refactor`: Kod değişikliği (yeni özellik veya hata düzeltmesi değil)
- `perf`: Performans iyileştirmesi
- `test`: Test ekleme veya düzenleme
- `chore`: Genel bakım

## Örnekler

```
feat(auth): Kullanıcı girişi ekleme
fix(home): Film listesi yükleme hatası düzeltildi
docs(readme): Kurulum talimatları güncellendi
style(ui): Buton renkleri düzenlendi
refactor(api): API çağrıları optimize edildi
perf(images): Resim önbellekleme eklendi
test(movie): Film detay sayfası testleri eklendi
chore(deps): Bağımlılıklar güncellendi
```

## Kurallar

1. Commit mesajı 50 karakterden kısa olmalı
2. İlk harf büyük olmalı
3. Nokta ile bitmemeli
4. Emoji kullanılmamalı
5. Türkçe karakter kullanılmamalı
