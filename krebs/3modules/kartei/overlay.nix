# GENERATED from the pre-migration kartei eval (kartei branch flat).
# Stockholm-specific data that no longer lives in kartei: via routes,
# ip prefixes, dns, sitemap, host flags, extraZones, ssh privkey
# locations, uid assignments.  Hand-edit as needed; this file is now
# the source of truth.
{
  # uid assignments are stockholm policy; everything else about users
  # (mail, ssh, pgp keys) lives in kartei.
  users = {
    tv.uid = 1337;
    vv.uid = 2000;
  };

  hosts = {
    ace = {
      external = true;
      nets.retiolum.via = "internet";
    };
    ada = {
      external = true;
    };
    adelaide = {
      external = true;
      nets.retiolum.via = "internet";
    };
    aendernix = {
      external = true;
    };
    aenderpad = {
      external = true;
    };
    aergia = {
      consul = true;
      monitoring = true;
    };
    ahorn = {
      external = true;
    };
    ahuatangata = {
      external = true;
    };
    aland = {
      external = true;
    };
    alnus = {
      ssh.privkey.path = "/run/secret/ssh.id_rsa";
      ssh.privkey.type = "rsa";
    };
    amy = {
      external = true;
      nets.retiolum.via = "internet";
    };
    astrid = {
      external = true;
    };
    au = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    bernie = {
      external = true;
      nets.retiolum.via = "internet";
    };
    bill = {
      external = true;
      nets.retiolum.via = "internet";
    };
    blob64 = {
      external = true;
      nets.retiolum.via = "internet";
    };
    blue = {
      consul = true;
      monitoring = true;
    };
    branchiopoda = {
      external = true;
    };
    bu = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_rsa";
      ssh.privkey.type = "rsa";
    };
    cake = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    catalonia = {
      external = true;
    };
    cherry = {
      external = true;
    };
    christina = {
      external = true;
      nets.retiolum.via = "internet";
    };
    chungus = {
      external = true;
    };
    clara = {
      external = true;
      nets.retiolum.via = "internet";
    };
    coaxmetal = {
      consul = true;
      monitoring = true;
    };
    copepoda = {
      external = true;
    };
    crapi = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    cream = {
      external = true;
    };
    crustacea = {
      external = true;
    };
    cyclida = {
      external = true;
    };
    daedalus = {
      consul = true;
      monitoring = true;
    };
    dan = {
      external = true;
      nets.retiolum.via = "internet";
    };
    dimitra = {
      external = true;
    };
    dimitrios = {
      external = true;
    };
    dimitriosxps = {
      external = true;
    };
    doctor = {
      external = true;
      nets.retiolum.via = "internet";
    };
    domsen-backup = {
      external = true;
    };
    domsen-pixel = {
      external = true;
      monitoring = true;
    };
    donna = {
      external = true;
      nets.retiolum.via = "internet";
    };
    doritslaptop = {
      external = true;
    };
    eliza = {
      external = true;
      nets.retiolum.via = "internet";
    };
    enklave = {
      nets.retiolum.via = "internet";
    };
    eva = {
      external = true;
      nets.retiolum.via = "internet";
    };
    eve = {
      external = true;
      nets.retiolum.via = "internet";
    };
    evo = {
      external = true;
    };
    fatteh = {
      external = true;
    };
    filebitch = {
      ci = true;
      nets.shack.ip4.prefix = "10.42.0.0/16";
    };
    fileleech = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    firecracker = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    flap = {
      extraZones."krebsco.de" = "flap              IN A      162.248.11.162";
    };
    fu = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    ful = {
      external = true;
    };
    g7power = {
      external = true;
    };
    graham = {
      external = true;
      nets.retiolum.via = "internet";
    };
    green = {
      consul = true;
      monitoring = true;
    };
    gum = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
      extraZones."krebsco.de" = ''
        abook.euer        IN A      142.132.189.140
        admin.work.euer   IN A      142.132.189.140
        api.work.euer     IN A      142.132.189.140
        atuin.euer        IN A      142.132.189.140
        board.euer        IN A      142.132.189.140
        bookmark.euer     IN A      142.132.189.140
        book.euer         IN A      142.132.189.140
        boot              IN A      142.132.189.140
        boot.euer         IN A      142.132.189.140
        build.euer        IN A      142.132.189.140
        bw.euer           IN A      142.132.189.140
        cache.euer        IN A      142.132.189.140
        cache.gum         IN A      142.132.189.140
        cgit.euer         IN A      142.132.189.140
        dl.euer           IN A      142.132.189.140
        dns.euer          IN A      142.132.189.140
        dockerhub         IN A      142.132.189.140
        etherpad.euer     IN A      142.132.189.140
        euer              IN A      142.132.189.140
        feed.euer         IN A      142.132.189.140
        ghook             IN A      142.132.189.140
        git.euer          IN A      142.132.189.140
        gold              IN A      142.132.189.140
        graph             IN A      142.132.189.140
        gum               IN A      142.132.189.140
        iso.euer          IN A      142.132.189.140
        maps.work.euer    IN A      142.132.189.140
        meet.euer         IN A      142.132.189.140
        mon.euer          IN A      142.132.189.140
        music.euer        IN A      142.132.189.140
        netdata.euer      IN A      142.132.189.140
        ntfy.euer         IN A      142.132.189.140
        o.euer            IN A      142.132.189.140
        paper.euer        IN A      142.132.189.140
        photostore        IN A      142.132.189.140
        play.work.euer    IN A      142.132.189.140
        push.work.euer    IN A      142.132.189.140
        rss.euer          IN A      142.132.189.140
        mdrss.euer        IN A      142.132.189.140
        share.euer        IN A      142.132.189.140
        ul.work.euer      IN A      142.132.189.140
        wg.euer           IN A      142.132.189.140
        wiki.euer         IN A      142.132.189.140
        wikisearch        IN A      142.132.189.140
        work.euer         IN A      142.132.189.140
        shop.euer         IN A      142.132.189.140
        matrix.euer       IN A      142.132.189.140
        element.euer      IN A      142.132.189.140

        mediengewitter    IN CNAME  over.dose.io.
        nixos.unstable    IN CNAME  krebscode.github.io.
        pigstarter        IN CNAME  makefu.github.io.

        euer              IN MX 1   aspmx.l.google.com.

        io                IN NS     gum.krebsco.de.
      '';
      nets.retiolum.via = "internet";
      nets.wiregrill.via = "internet";
    };
    hasegateway = {
      external = true;
    };
    helsinki = {
      external = true;
    };
    hilum = {
      monitoring = true;
    };
    horisa = {
      external = true;
    };
    hotdog = {
      ci = true;
    };
    hu = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    ian = {
      external = true;
      nets.retiolum.via = "internet";
    };
    icarus = {
      consul = true;
      monitoring = true;
      secure = true;
    };
    ignavia = {
      consul = true;
      monitoring = true;
    };
    ioka = {
      external = true;
    };
    irene = {
      external = true;
      nets.retiolum.via = "internet";
    };
    iti = {
      external = true;
    };
    jack = {
      external = true;
      nets.retiolum.via = "internet";
    };
    jackson = {
      external = true;
      nets.retiolum.via = "internet";
    };
    jacquardmachine = {
      external = true;
    };
    jamie = {
      external = true;
      nets.retiolum.via = "internet";
    };
    jongepad = {
      external = true;
    };
    joy = {
      external = true;
      nets.retiolum.via = "internet";
    };
    justraute = {
      external = true;
    };
    kabsa = {
      external = true;
    };
    keller = {
      external = true;
    };
    kfbox = {
      external = true;
    };
    kibbeh = {
      external = true;
    };
    lasspi = {
      monitoring = true;
    };
    latte = {
      extraZones."krebsco.de" = "latte.euer     IN A      178.254.30.202";
      nets.retiolum.via = "internet";
    };
    leg = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    littleT = {
      consul = true;
      monitoring = true;
      secure = true;
    };
    makanek = {
      external = true;
    };
    malacostraca = {
      external = true;
    };
    manakish = {
      external = true;
    };
    martha = {
      external = true;
      nets.retiolum.via = "internet";
    };
    massulus = {
      consul = true;
      monitoring = true;
    };
    matchbox = {
      external = true;
    };
    miaoski = {
      external = true;
    };
    mickey = {
      external = true;
      nets.retiolum.via = "internet";
    };
    mors = {
      monitoring = true;
      secure = true;
    };
    mu = {
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    mystacocarida = {
      external = true;
    };
    nardole = {
      external = true;
      nets.retiolum.via = "internet";
    };
    ne = {
      extraZones."krebsco.de" = ''
        @ 60 IN MX 5 ne
        @ 60 IN TXT "v=spf1 mx -all"
        ne 60 IN A 159.195.31.38
        ne 60 IN AAAA 2a0a:4cc0:c1:5eb0::1
        cgit 60 IN A 159.195.31.38
        cgit 60 IN AAAA 2a0a:4cc0:c1:5eb0::1
        cgit.ne 60 IN A 159.195.31.38
        search.ne 60 IN AAAA 2a0a:4cc0:c1:5eb0::1
        tv 300 IN NS ne
      '';
      nets.internet.ip6.prefixLength = 64;
      nets.mycelium.via = "internet";
      nets.retiolum.via = "internet";
      nets.wiregrill.via = "internet";
    };
    neoprism = {
      consul = true;
      monitoring = true;
      extraZones."krebsco.de" = ''
        p         60 IN A 95.217.192.59
        c         60 IN A 95.217.192.59
        paste     60 IN A 95.217.192.59
      '';
      nets.internet.ip6.prefix = "2a01:4f9:4a:4f1a::2/64";
    };
    nomic = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    nxbg = {
      external = true;
    };
    nxdc = {
      external = true;
    };
    nxnv = {
      external = true;
    };
    nxnx = {
      external = true;
    };
    nxrm = {
      external = true;
    };
    okelmann = {
      external = true;
    };
    omo = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    orange = {
      consul = true;
      monitoring = true;
    };
    papawhakaaro = {
      external = true;
    };
    phone = {
      external = true;
      monitoring = true;
    };
    ponte = {
      extraZones."krebsco.de" = ''
        @ IN A 141.147.36.79
        ns1 IN A 141.147.36.79
      '';
      nets.intranet.ip4.prefix = "10.0.0.234/24";
      nets.retiolum.via = "internet";
    };
    porree = {
      external = true;
    };
    prism = {
      consul = true;
      monitoring = true;
      extraZones."krebsco.de" = ''
        cache     60 IN A 95.216.1.150
        prism     60 IN A 95.216.1.150
        social    60 IN A 95.216.1.150
      '';
      extraZones."lassul.us" = ''
        $TTL 3600
        @ IN SOA dns16.ovh.net. tech.ovh.net. (2017093001 86400 3600 3600000 300)
                            60 IN NS     ns16.ovh.net.
                            60 IN NS     dns16.ovh.net.
                            60 IN A      95.216.1.150
                            60 IN AAAA   95.216.1.150
                               IN MX     5 mail.lassul.us.
                            60 IN TXT    "v=spf1 mx -all"
                            60 IN TXT    ( "v=DKIM1; k=rsa; t=s; s=*; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDUv3DMndFellqu208feABEzT/PskOfTSdJCOF/HELBR0PHnbBeRoeHEm9XAcOe/Mz2t/ysgZ6JFXeFxCtoM5fG20brUMRzsVRxb9Ur5cEvOYuuRrbChYcKa+fopu8pYrlrqXD3miHISoy6ErukIYCRpXWUJHi1TlNQhLWFYqAaywIDAQAB" )
        default._domainkey  60 IN TXT    "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDUv3DMndFellqu208feABEzT/PskOfTSdJCOF/HELBR0PHnbBeRoeHEm9XAcOe/Mz2t/ysgZ6JFXeFxCtoM5fG20brUMRzsVRxb9Ur5cEvOYuuRrbChYcKa+fopu8pYrlrqXD3miHISoy6ErukIYCRpXWUJHi1TlNQhLWFYqAaywIDAQAB"
        cache               60 IN A      95.216.1.150
        cgit                60 IN A      95.216.1.150
        pad                 60 IN A      95.216.1.150
        codi                60 IN A      95.216.1.150
        go                  60 IN A      95.216.1.150
        io                  60 IN NS     ions.lassul.us.
        ions                60 IN A      95.216.1.150
        lol                 60 IN A      95.216.1.150
        matrix              60 IN A      95.216.1.150
        paste               60 IN A      95.216.1.150
        radio               60 IN A      95.216.1.150
        jitsi               60 IN A      95.216.1.150
        streaming           60 IN A      95.216.1.150
        mumble              60 IN A      95.216.1.150
        mail                60 IN A      95.216.1.150
        mail                60 IN AAAA   2a01:4f9:2a:1e9::1
        flix                60 IN A      95.216.1.150
        flex                60 IN A      95.216.1.150
        flux                60 IN A      95.216.1.150
        testing             60 IN A      95.216.1.150
        schrott             60 IN A      95.216.1.150
      '';
      nets.internet.ip4.prefix = "0.0.0.0/0";
      nets.internet.ip6.prefix = "2a01:4f9:2a:1e9::/64";
      nets.retiolum.via = "internet";
      nets.wiregrill.via = "internet";
    };
    puyak = {
      ci = true;
    };
    qubasa = {
      external = true;
    };
    querel = {
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    radio = {
      consul = true;
      monitoring = true;
    };
    rauter = {
      external = true;
    };
    river = {
      external = true;
      nets.retiolum.via = "internet";
    };
    rose = {
      external = true;
      nets.retiolum.via = "internet";
    };
    rtgraphene = {
      external = true;
    };
    rtjure = {
      external = true;
    };
    rtrunner = {
      external = true;
    };
    rtspinner = {
      external = true;
    };
    rtworker = {
      external = true;
    };
    ru = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    ruby = {
      external = true;
      nets.retiolum.via = "internet";
    };
    ryan = {
      external = true;
      nets.retiolum.via = "internet";
    };
    sdev = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    shodan = {
      consul = true;
      monitoring = true;
      secure = true;
    };
    sicily = {
      external = true;
    };
    skynet = {
      consul = true;
      monitoring = true;
      secure = true;
    };
    snake = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    sokrateslaptop = {
      external = true;
    };
    studio = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    styx = {
      consul = true;
      monitoring = true;
    };
    tablet = {
      external = true;
      monitoring = true;
    };
    tabula = {
      external = true;
    };
    tahina = {
      external = true;
    };
    tantulocarida = {
      external = true;
    };
    tegan = {
      external = true;
      nets.retiolum.via = "internet";
    };
    thecostraca = {
      external = true;
    };
    tofu = {
      external = true;
    };
    tpsw = {
      external = true;
    };
    tumaukainga = {
      external = true;
    };
    turingmachine = {
      external = true;
      nets.retiolum.via = "internet";
    };
    ubik = {
      consul = true;
      monitoring = true;
    };
    unnamed = {
      external = true;
    };
    uppreisn = {
      external = true;
    };
    v60 = {
      external = true;
    };
    verex = {
      external = true;
    };
    vicki = {
      external = true;
      nets.retiolum.via = "internet";
    };
    vislor = {
      external = true;
      nets.retiolum.via = "internet";
    };
    wbob = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    wilfred = {
      external = true;
      nets.retiolum.via = "internet";
    };
    wolf = {
      ci = true;
    };
    workbox = {
      external = true;
    };
    x = {
      ssh.privkey.path = "/run/secret/ssh_host_ed25519_key";
    };
    xavier = {
      external = true;
      nets.retiolum.via = "internet";
    };
    xerxes = {
      monitoring = true;
      secure = true;
    };
    xu = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    yasmin = {
      external = true;
    };
    yellow = {
      consul = true;
      monitoring = true;
    };
    zaatar = {
      external = true;
    };
    zoppo = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_ed25519";
    };
    zu = {
      secure = true;
      ssh.privkey.path = "/run/secret/ssh.id_rsa";
      ssh.privkey.type = "rsa";
    };
  };

  dns.providers = {
    "lassul.us" = "zones";
    "viljetic.de" = "regfish";
  };

  sitemap = {
    "http://cgit.krebsco.de".desc = "Git repositories";
    "http://krebs.ni.r".desc = "krebs-pages mirror";
  };
}
