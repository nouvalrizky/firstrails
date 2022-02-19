class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.published?

    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end


# Explanation of The Concept

# KALO MISAL JADWAL DIMAJUIN
# Awal: 3 Sore, Setelah diperbarui: 9 Pagi

# Maka akan ada 2 job diantrian, job sebelum (3 sore) dan setelah update (9 pagi)

# PUBLISH_AT VALUE NOW IS =  9 Pagi

# Job 2 (jalan pas 9 pagi) : pas dijalanin kena pengecekan pertama, apa sudah publish? SALAH.
#         Lanjut ke pengecekan kedua, jam publish_at (9 pagi) lebih dari jam sekarang (9 pagi lewat, karena urutan kode belakangan)? SALAH
#         Lanjut ke baris publish, Sehingga di Job ini tweet telah ke publish. DONE

# Job 1 (Jalan pas 3 Sore) : pas dijalanin kena pengecekan pertama, apa sudah publish? BETUL. SO RETURN

# ====================================================

# KALO MISAL JADWAL MALAH DIUNDUR
# Awal: 9 Pagi, Setelah diperbarui: 3 Sore

# Maka akan ada 2 job diantrian, job sebelum (9 Pagi) dan setelah update (3 Sore)

# PUBLISH_AT VALUE NOW IS =  3 Sore

# Job 1 (Jalan pas 9 pagi) = pas dijalanin kena pengecekan pertama, apa sudah publish? SALAH.
#         Lanjut ke pengecekan kedua, jam publish_at (3 sore) lebih dari jam sekarang (9 pagi lewat)? BETUL. SO RETURN

# Job 2 (Jalan pas 3 sore) = pas dijalanin kena pengecekan pertama, apa sudah publish? SALAH.
#         Lanjut ke pengecekan kedua, jam publish (3 sore) lebih dari jam sekarang (3 sore lewat)? SALAH
#         Lanjut ke baris publish, sehingga tweet akan di publish DONE

