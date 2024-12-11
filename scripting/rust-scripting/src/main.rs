fn main() {
    let s = String::from(
        "
API_KEY=projects/758456784111/secrets/token-mail:latest
COOKIE=projects/758456784111/secrets/mpv-cookie:latest
SESS_SECRET=projects/758456784111/secrets/mpv-sess-secret:latest
SIGNATURE=projects/758456784111/secrets/mpv-signature:latest
SMTP_MAIL_PASS=projects/758456784111/secrets/mpv-smtp-mail-pass:latest
SQLDB_PASSWORD=projects/758456784111/secrets/mpv-mysql-password:latest
SQLDB_USERNAME=projects/758456784111/secrets/mpv-mysql-username:latest
SQLDB_WRITE_PASSWORD=projects/758456784111/secrets/mpv-db-write-password:latest
SQLDB_WRITE_USERNAME=projects/758456784111/secrets/mpv-db-write-username:latest
TELKOM_API_KEY=projects/758456784111/secrets/mpv-admin-telkom-api-key:latest",
    );

    for line in s.lines(){
        println!("_SECRET_{}", line.replace("=", ": "));
    }

}
