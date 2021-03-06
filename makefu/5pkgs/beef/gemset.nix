{
  activemodel = {
    dependencies = ["activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xjy8fg7n5wwv29ngvvdf5r6815s5f0knzyswxh8w6z8f8qj5wr7";
      type = "gem";
    };
    version = "6.1.4";
  };
  activerecord = {
    dependencies = ["activemodel" "activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18897s9h9kha8vgky1yfq4x91m3p81k6rkrb1fgjlnqnvarh9vg0";
      type = "gem";
    };
    version = "6.1.4";
  };
  activesupport = {
    dependencies = ["concurrent-ruby" "i18n" "minitest" "tzinfo" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kqgywy4cj3h5142dh7pl0xx5nybp25jn0ykk0znziivzks68xdk";
      type = "gem";
    };
    version = "6.1.4";
  };
  addressable = {
    dependencies = ["public_suffix"];
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "022r3m9wdxljpbya69y2i3h9g3dhhfaqzidf95m6qjzms792jvgp";
      type = "gem";
    };
    version = "2.8.0";
  };
  ansi = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14ims9zfal4gs2wpx2m5rd8zsrl2k794d359shkrsgg3fhr2a22l";
      type = "gem";
    };
    version = "1.5.0";
  };
  archive-zip = {
    dependencies = ["io-like"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ywpxgmhazmqcsjf3qhim3rdnbyjjl9nkj91kqgmrjq5q8j0r386";
      type = "gem";
    };
    version = "0.12.0";
  };
  ast = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04nc8x27hlzlrr5c2gn7mar4vdr0apw5xg22wp6m8dx3wqr04a0y";
      type = "gem";
    };
    version = "2.4.2";
  };
  async = {
    dependencies = ["console" "nio4r" "timers"];
    groups = ["default" "ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mdv66xn5xjyaidyrp66mfnx7d4habkbfmx9y57k75h5q6fd2b65";
      type = "gem";
    };
    version = "1.30.1";
  };
  async-dns = {
    dependencies = ["async-io"];
    groups = ["ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jwgzdp0qi31c8wlflhqvjj5w1vfwyai9j2yzxrpsqjzcmwhiv90";
      type = "gem";
    };
    version = "1.2.6";
  };
  async-io = {
    dependencies = ["async"];
    groups = ["default" "ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10l9m0x2ffvsaaxc4mfalrljjx13njkyir9w6yfif8wpszc291h8";
      type = "gem";
    };
    version = "1.32.2";
  };
  browserstack-local = {
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wch4m064szfkk9fyp7f1yvkpbc3ajqdql0k4pjmqj2z38spsz9i";
      type = "gem";
    };
    version = "1.3.0";
  };
  buftok = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rzsy1vy50v55x9z0nivf23y0r9jkmq6i130xa75pq9i8qrn1mxs";
      type = "gem";
    };
    version = "0.2.0";
  };
  byebug = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nx3yjf4xzdgb8jkmk2344081gqr22pgjqnmjg2q64mj5d6r9194";
      type = "gem";
    };
    version = "11.1.3";
  };
  capybara = {
    dependencies = ["addressable" "mini_mime" "nokogiri" "rack" "rack-test" "regexp_parser" "xpath"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1viqcpsngy9fqjd68932m43ad6xj656d1x33nx9565q57chgi29k";
      type = "gem";
    };
    version = "3.35.3";
  };
  childprocess = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ic028k8xgm2dds9mqnvwwx3ibaz32j8455zxr9f4bcnviyahya5";
      type = "gem";
    };
    version = "3.0.0";
  };
  coderay = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jvxqxzply1lwp7ysn94zjhh57vc14mcshw1ygw14ib8lhc00lyw";
      type = "gem";
    };
    version = "1.1.3";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nwad3211p7yv9sda31jmbyw6sdafzmdi2i2niaz6f0wk5nq9h0f";
      type = "gem";
    };
    version = "1.1.9";
  };
  console = {
    dependencies = ["fiber-local"];
    groups = ["default" "ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04vhg3vnj2ky00fld4v6qywx32z4pjsa7l8i7sl1bl213s8334l9";
      type = "gem";
    };
    version = "1.13.1";
  };
  curb = {
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q7kqswm780vx1fannnrprbfbsp166smgyszgip5q7b859mk89wp";
      type = "gem";
    };
    version = "0.9.11";
  };
  daemons = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fki1aipqafqlg8xy25ykk0ql1dciy9kk6lcp5gzgkh9ccmaxzf3";
      type = "gem";
    };
    version = "1.4.0";
  };
  diff-lcs = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0m925b8xc6kbpnif9dldna24q1szg4mk0fvszrki837pfn46afmz";
      type = "gem";
    };
    version = "1.4.4";
  };
  domain_name = {
    dependencies = ["unf"];
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lcqjsmixjp52bnlgzh4lg9ppsk52x9hpwdjd53k8jnbah2602h0";
      type = "gem";
    };
    version = "0.5.20190701";
  };
  em-websocket = {
    dependencies = ["eventmachine" "http_parser.rb"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1mg1mx735a0k1l8y14ps2mxdwhi5r01ikydf34b0sp60v66nvbkb";
      type = "gem";
    };
    version = "0.5.2";
  };
  equalizer = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1kjmx3fygx8njxfrwcmn7clfhjhb6bvv3scy2lyyi0wqyi3brra4";
      type = "gem";
    };
    version = "0.0.11";
  };
  erubis = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fj827xqjs91yqsydf0zmfyw9p4l2jz5yikg3mppz6d7fi8kyrb3";
      type = "gem";
    };
    version = "2.7.0";
  };
  espeak-ruby = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0d658zr53jibyrs5qnic7bfl6h69k5987s8asncsbnxwbzzilj6y";
      type = "gem";
    };
    version = "1.0.4";
  };
  event_emitter = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "148k9qv8102l3m6klc24dwip79f9y4bjr5z19dckd7ffbjyrf9n7";
      type = "gem";
    };
    version = "0.2.6";
  };
  eventmachine = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wh9aqb0skz80fhfn66lbpr4f86ya2z5rx6gm5xlfhd05bj1ch4r";
      type = "gem";
    };
    version = "1.2.7";
  };
  execjs = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "121h6af4i6wr3wxvv84y53jcyw2sk71j5wsncm6wq6yqrwcrk4vd";
      type = "gem";
    };
    version = "2.8.1";
  };
  ffi = {
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wgvaclp4h9y8zkrgz8p2hqkrgr4j7kz0366mik0970w532cbmcq";
      type = "gem";
    };
    version = "1.15.3";
  };
  ffi-compiler = {
    dependencies = ["ffi" "rake"];
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0c2caqm9wqnbidcb8dj4wd3s902z15qmgxplwyfyqbwa0ydki7q1";
      type = "gem";
    };
    version = "1.0.1";
  };
  fiber-local = {
    groups = ["default" "ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vrxxb09fc7aicb9zb0pmn5akggjy21dmxkdl3w949y4q05rldr9";
      type = "gem";
    };
    version = "1.0.0";
  };
  geckodriver-helper = {
    dependencies = ["archive-zip"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14zw0hxsqhz8pirm4rll0wmv2yhsfdjf5pkp3pxg46jsryfpm288";
      type = "gem";
    };
    version = "0.24.0";
  };
  hashie = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02bsx12ihl78x0vdm37byp78jjw2ff6035y7rrmbd90qxjwxr43q";
      type = "gem";
    };
    version = "4.1.0";
  };
  hashie-forbidden_attributes = {
    dependencies = ["hashie"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1chgg5d2iddja6ww02x34g8avg11fzmzcb8yvnqlykii79zx6vis";
      type = "gem";
    };
    version = "0.1.1";
  };
  http = {
    dependencies = ["addressable" "http-cookie" "http-form_data" "http-parser"];
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0z8vmvnkrllkpzsxi94284di9r63g9v561a16an35izwak8g245y";
      type = "gem";
    };
    version = "4.4.1";
  };
  http-accept = {
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09m1facypsdjynfwrcv19xcb1mqg8z6kk31g8r33pfxzh838c9n6";
      type = "gem";
    };
    version = "1.7.0";
  };
  http-cookie = {
    dependencies = ["domain_name"];
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19370bc97gsy2j4hanij246hv1ddc85hw0xjb6sj7n1ykqdlx9l9";
      type = "gem";
    };
    version = "1.0.4";
  };
  http-form_data = {
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wx591jdhy84901pklh1n9sgh74gnvq1qyqxwchni1yrc49ynknc";
      type = "gem";
    };
    version = "2.3.0";
  };
  http-parser = {
    dependencies = ["ffi-compiler"];
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18qqvckvqjffh88hfib6c8pl9qwk9gp89w89hl3f2s1x8hgyqka1";
      type = "gem";
    };
    version = "1.2.3";
  };
  "http_parser.rb" = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15nidriy0v5yqfjsgsra51wmknxci2n2grliz78sf9pga3n0l7gi";
      type = "gem";
    };
    version = "0.6.0";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0g2fnag935zn2ggm5cn6k4s4xvv53v2givj1j90szmvavlpya96a";
      type = "gem";
    };
    version = "1.8.10";
  };
  io-console = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pmafwxh8z1apnk7bb1ibnbhfrgb1jgilxm4j8d0fcqlc2ggmbja";
      type = "gem";
    };
    version = "0.5.9";
  };
  io-like = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01l358q8smk99k6c2h5zygyw4flqg93zk4x61amp9slbs4j0gbms";
      type = "gem";
    };
    version = "0.3.1";
  };
  irb = {
    dependencies = ["reline"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s4yjh5p1n05cm3pglh3g4ssrgy67x2bn3bsl0sydbm8mlf3xivr";
      type = "gem";
    };
    version = "1.3.6";
  };
  json = {
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lrirj0gw420kw71bjjlqkqhqbrplla61gbv1jzgsz6bv90qr3ci";
      type = "gem";
    };
    version = "2.5.1";
  };
  maxmind-db = {
    groups = ["geoip"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0n0cazcsjd5cm50qg3iiy3cqvjg1zc40mmcllx88lj9wg0f1j4v9";
      type = "gem";
    };
    version = "1.1.1";
  };
  memoizable = {
    dependencies = ["thread_safe"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0v42bvghsvfpzybfazl14qhkrjvx0xlmxz0wwqc960ga1wld5x5c";
      type = "gem";
    };
    version = "0.4.2";
  };
  method_source = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pnyh44qycnf9mzi1j6fywd5fkskv3x7nmsqrrws0rjn5dd4ayfp";
      type = "gem";
    };
    version = "1.0.0";
  };
  mime-types = {
    dependencies = ["mime-types-data"];
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zj12l9qk62anvk9bjvandpa6vy4xslil15wl6wlivyf51z773vh";
      type = "gem";
    };
    version = "3.3.1";
  };
  mime-types-data = {
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dlxwc75iy0dj23x824cxpvpa7c8aqcpskksrmb32j6m66h5mkcy";
      type = "gem";
    };
    version = "3.2021.0704";
  };
  mini_mime = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kb7jq3wjgckmkzna799y5qmvn6vg52878bkgw35qay6lflcrwih";
      type = "gem";
    };
    version = "1.1.0";
  };
  mini_portile2 = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lvxm91hi0pabnkkg47wh1siv56s6slm2mdq1idfm86dyfidfprq";
      type = "gem";
    };
    version = "2.6.1";
  };
  minitest = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19z7wkhg59y8abginfrm2wzplz7py3va8fyngiigngqvsws6cwgl";
      type = "gem";
    };
    version = "5.14.4";
  };
  mojo_magick = {
    groups = ["default" "ext_qrcode"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0r5b4jckcylg5q8dm0rzczkfaifjqf9p62hkkgj52k708q00vcpv";
      type = "gem";
    };
    version = "0.6.6";
  };
  msfrpc-client = {
    dependencies = ["msgpack"];
    groups = ["ext_msf"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07hjr9j39n0hxlh26a69bsyhkgflxv8kwv8d10930njw3vgknq22";
      type = "gem";
    };
    version = "1.1.2";
  };
  msgpack = {
    groups = ["default" "ext_msf"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06iajjyhx0rvpn4yr3h1hc4w4w3k59bdmfhxnjzzh76wsrdxxrc6";
      type = "gem";
    };
    version = "1.4.2";
  };
  multipart-post = {
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zgw9zlwh2a6i1yvhhc4a84ry1hv824d6g2iw2chs3k5aylpmpfj";
      type = "gem";
    };
    version = "2.1.1";
  };
  mustermann = {
    dependencies = ["ruby2_keywords"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ccm54qgshr1lq3pr1dfh7gphkilc19dp63rw6fcx7460pjwy88a";
      type = "gem";
    };
    version = "1.1.1";
  };
  naught = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wwjx35zgbc0nplp8a866iafk4zsrbhwwz4pav5gydr2wm26nksg";
      type = "gem";
    };
    version = "1.1.0";
  };
  netrc = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gzfmcywp1da8nzfqsql2zqi648mfnx6qwkig3cv36n9m0yy676y";
      type = "gem";
    };
    version = "0.11.0";
  };
  nio4r = {
    groups = ["default" "ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xk64wghkscs6bv2n22853k2nh39d131c6rfpnlw12mbjnnv9v1v";
      type = "gem";
    };
    version = "2.5.8";
  };
  nokogiri = {
    dependencies = ["mini_portile2" "racc"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1iav4jrklvm8938bxhby0khs36mdndhvwia4hc85zxcb0yl1k8ll";
      type = "gem";
    };
    version = "1.12.2";
  };
  otr-activerecord = {
    dependencies = ["activerecord" "hashie-forbidden_attributes"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fzid0yyiyq565q1yi312adgfy3ybwkl5bc8ng338zb2szvjd3p3";
      type = "gem";
    };
    version = "2.0.1";
  };
  parallel = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0055br0mibnqz0j8wvy20zry548dhkakws681bhj3ycb972awkzd";
      type = "gem";
    };
    version = "1.20.1";
  };
  parseconfig = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09qhqrhcy7jwz4wls2l6z4dx4428csy27nbscxn72rd973k390yi";
      type = "gem";
    };
    version = "1.1.0";
  };
  parser = {
    dependencies = ["ast"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06ma6w87ph8lnc9z4hi40ynmcdnjv0p8x53x0s3fjkz4q2p6sxh5";
      type = "gem";
    };
    version = "3.0.2.0";
  };
  power_assert = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "172qfmzwxdf82bmwgcb13hnz9i3p6i2s2nijxnx6r63kn3drjppr";
      type = "gem";
    };
    version = "2.0.0";
  };
  pry = {
    dependencies = ["coderay" "method_source"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0iyw4q4an2wmk8v5rn2ghfy2jaz9vmw2nk8415nnpx2s866934qk";
      type = "gem";
    };
    version = "0.13.1";
  };
  pry-byebug = {
    dependencies = ["byebug" "pry"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "096y5vmzpyy4x9h4ky4cs4y7d19vdq9vbwwrqafbh5gagzwhifiv";
      type = "gem";
    };
    version = "3.9.0";
  };
  public_suffix = {
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xqcgkl7bwws1qrlnmxgh8g4g9m10vg60bhlw40fplninb3ng6d9";
      type = "gem";
    };
    version = "4.0.6";
  };
  qr4r = {
    dependencies = ["mojo_magick" "rqrcode_core"];
    groups = ["ext_qrcode"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0g534ra5v61lnxwp0qg9apmhk1ra44zax9fg1g7jlhbaf2ni6cpk";
      type = "gem";
    };
    version = "0.6.1";
  };
  racc = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "178k7r0xn689spviqzhvazzvxfq6fyjldxb3ywjbgipbfi4s8j1g";
      type = "gem";
    };
    version = "1.5.2";
  };
  rack = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0i5vs0dph9i5jn8dfc6aqd6njcafmb20rwqngrf759c9cvmyff16";
      type = "gem";
    };
    version = "2.2.3";
  };
  rack-protection = {
    dependencies = ["rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "159a4j4kragqh0z0z8vrpilpmaisnlz3n7kgiyf16bxkwlb3qlhz";
      type = "gem";
    };
    version = "2.1.0";
  };
  rack-test = {
    dependencies = ["rack"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rh8h376mx71ci5yklnpqqn118z3bl67nnv5k801qaqn1zs62h8m";
      type = "gem";
    };
    version = "1.1.0";
  };
  rainbow = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bb2fpjspydr6x0s8pn1pqkzmxszvkfapv0p4627mywl7ky4zkhk";
      type = "gem";
    };
    version = "3.0.0";
  };
  rake = {
    groups = ["default" "ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15whn7p9nrkxangbs9hh75q585yfn66lv0v2mhj6q6dl6x8bzr2w";
      type = "gem";
    };
    version = "13.0.6";
  };
  rdoc = {
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19h5g3g7k7wggy9amfx8b3m09ss7wrakbrva2xnda9sw4chagx6y";
      type = "gem";
    };
    version = "6.3.2";
  };
  regexp_parser = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vg7imjnfcqjx7kw94ccj5r78j4g190cqzi1i59sh4a0l940b9cr";
      type = "gem";
    };
    version = "2.1.1";
  };
  reline = {
    dependencies = ["io-console"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10sib8k5w0x6s94infm657ys0k52kxql4cnkvfa7bcgy14r3qbza";
      type = "gem";
    };
    version = "0.2.6";
  };
  rest-client = {
    dependencies = ["http-accept" "http-cookie" "mime-types" "netrc"];
    groups = ["ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1qs74yzl58agzx9dgjhcpgmzfn61fqkk33k1js2y5yhlvc5l19im";
      type = "gem";
    };
    version = "2.1.0";
  };
  rexml = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08ximcyfjy94pm1rhcx04ny1vx2sk0x4y185gzn86yfsbzwkng53";
      type = "gem";
    };
    version = "3.2.5";
  };
  rqrcode_core = {
    groups = ["default" "ext_qrcode"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00kqasqja8zyzqvlgiwd9r0wndqk01qk5j68a8lhlz4ayrd4qy0y";
      type = "gem";
    };
    version = "0.2.0";
  };
  rr = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ngsigzy06lz40vnvzmkbn6ch6rlk0czfn8228cwvd3lc4qkggna";
      type = "gem";
    };
    version = "3.0.5";
  };
  rspec = {
    dependencies = ["rspec-core" "rspec-expectations" "rspec-mocks"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dwai7jnwmdmd7ajbi2q0k0lx1dh88knv5wl7c34wjmf94yv8w5q";
      type = "gem";
    };
    version = "3.10.0";
  };
  rspec-core = {
    dependencies = ["rspec-support"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wwnfhxxvrlxlk1a3yxlb82k2f9lm0yn0598x7lk8fksaz4vv6mc";
      type = "gem";
    };
    version = "3.10.1";
  };
  rspec-expectations = {
    dependencies = ["diff-lcs" "rspec-support"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sz9bj4ri28adsklnh257pnbq4r5ayziw02qf67wry0kvzazbb17";
      type = "gem";
    };
    version = "3.10.1";
  };
  rspec-mocks = {
    dependencies = ["diff-lcs" "rspec-support"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1d13g6kipqqc9lmwz5b244pdwc97z15vcbnbq6n9rlf32bipdz4k";
      type = "gem";
    };
    version = "3.10.2";
  };
  rspec-support = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15j52parvb8cgvl6s0pbxi2ywxrv6x0764g222kz5flz0s4mycbl";
      type = "gem";
    };
    version = "3.10.2";
  };
  rubocop = {
    dependencies = ["parallel" "parser" "rainbow" "regexp_parser" "rexml" "rubocop-ast" "ruby-progressbar" "unicode-display_width"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jrfcxs7qm2jamh44djz322c8xpg8zyllg6xyk0r0qnvk71dwlrn";
      type = "gem";
    };
    version = "0.92.0";
  };
  rubocop-ast = {
    dependencies = ["parser"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dbbll8k2xqdfpirzpfl3gi4asplay25mg91510i7qb601xbjpcy";
      type = "gem";
    };
    version = "1.8.0";
  };
  ruby-progressbar = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02nmaw7yx9kl7rbaan5pl8x5nn0y4j5954mzrkzi9i3dhsrps4nc";
      type = "gem";
    };
    version = "1.11.0";
  };
  ruby2_keywords = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vz322p8n39hz3b4a9gkmz9y7a5jaz41zrm2ywf31dvkqm03glgz";
      type = "gem";
    };
    version = "0.0.5";
  };
  rubyzip = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0grps9197qyxakbpw02pda59v45lfgbgiyw48i0mq9f2bn9y6mrz";
      type = "gem";
    };
    version = "2.3.2";
  };
  rushover = {
    dependencies = ["json" "rest-client"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0j6x61drcdfnbvgmkmrc92zw67acpfcz5h1a29sdf884zkwd1444";
      type = "gem";
    };
    version = "0.3.0";
  };
  selenium-webdriver = {
    dependencies = ["childprocess" "rubyzip"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0adcvp86dinaqq3nhf8p3m0rl2g6q0a4h52k0i7kdnsg1qz9k86y";
      type = "gem";
    };
    version = "3.142.7";
  };
  simple_oauth = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dw9ii6m7wckml100xhjc6vxpjcry174lbi9jz5v7ibjr3i94y8l";
      type = "gem";
    };
    version = "0.3.1";
  };
  sinatra = {
    dependencies = ["mustermann" "rack" "rack-protection" "tilt"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dd53rzpkxgs697pycbhhgc9vcnxra4ly4xar8ni6aiydx2f88zk";
      type = "gem";
    };
    version = "2.1.0";
  };
  slack-notifier = {
    groups = ["ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "001bipchr45sny33nlavqgxca9y1qqxa7xpi7pvjfqiybwzvm6nd";
      type = "gem";
    };
    version = "2.4.0";
  };
  sqlite3 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lja01cp9xd5m6vmx99zwn4r7s97r1w5cb76gqd8xhbm1wxyzf78";
      type = "gem";
    };
    version = "1.4.2";
  };
  sync = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1z9qlq4icyiv3hz1znvsq1wz2ccqjb1zwd6gkvnwg6n50z65d0v6";
      type = "gem";
    };
    version = "0.5.0";
  };
  term-ansicolor = {
    dependencies = ["tins"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xq5kci9215skdh27npyd3y55p812v4qb4x2hv3xsjvwqzz9ycwj";
      type = "gem";
    };
    version = "1.7.1";
  };
  test-unit = {
    dependencies = ["power_assert"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15isy7vhppbfd0032klirj9gxp65ygkzjdwrmm28xpirlcsk6qpd";
      type = "gem";
    };
    version = "3.4.4";
  };
  test-unit-context = {
    dependencies = ["test-unit"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dnvl3nm876nw7fx8m6q5zj0cgqhyj4vr7c18yl0zj36pn0wcmib";
      type = "gem";
    };
    version = "0.5.1";
  };
  test-unit-full = {
    dependencies = ["test-unit" "test-unit-context" "test-unit-notify" "test-unit-rr" "test-unit-runner-tap"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fivczw5d1b5krpjp23yipq8055p1d6wmis13xwl21xxwc1z2dsy";
      type = "gem";
    };
    version = "0.0.5";
  };
  test-unit-notify = {
    dependencies = ["test-unit"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dzv2d82z3rm1vl7qazgg48nlsdh5zp1z6rpijdj03y469yd6cyv";
      type = "gem";
    };
    version = "1.0.4";
  };
  test-unit-rr = {
    dependencies = ["rr" "test-unit"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l42wxvqqd4g1968syy1wmr4j9z3cad8v5vv22lr7my4wjgz0sil";
      type = "gem";
    };
    version = "1.0.5";
  };
  test-unit-runner-tap = {
    dependencies = ["test-unit"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1r3yi3zb9ximl3xpaqi0clm4i013alkqivn4gi6dn7zliqhz5622";
      type = "gem";
    };
    version = "1.1.2";
  };
  thin = {
    dependencies = ["daemons" "eventmachine" "rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "123bh7qlv6shk8bg8cjc84ix8bhlfcilwnn3iy6zq3l57yaplm9l";
      type = "gem";
    };
    version = "1.8.1";
  };
  thread_safe = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nmhcgq6cgz44srylra07bmaw99f5271l0dpsvl5f75m44l0gmwy";
      type = "gem";
    };
    version = "0.3.6";
  };
  tilt = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rn8z8hda4h41a64l0zhkiwz2vxw9b1nb70gl37h1dg2k874yrlv";
      type = "gem";
    };
    version = "2.0.10";
  };
  timers = {
    groups = ["default" "ext_dns"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00xdi97gm01alfqhjgvv5sff9n1n2l6aym69s9jh8l9clg63b0jc";
      type = "gem";
    };
    version = "4.3.3";
  };
  tins = {
    dependencies = ["sync"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nzp88y19rqlcizp1nw8m44fvfxs9g3bhjpscz44dwfawfrmr0cb";
      type = "gem";
    };
    version = "1.29.1";
  };
  twitter = {
    dependencies = ["addressable" "buftok" "equalizer" "http" "http-form_data" "http_parser.rb" "memoizable" "multipart-post" "naught" "simple_oauth"];
    groups = ["ext_notifications"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13dmkjgsnym1avym9f7y2i2h3mlk8crqvc87drrzr4f0sf9l8g2y";
      type = "gem";
    };
    version = "7.0.0";
  };
  tzinfo = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10qp5x7f9hvlc0psv9gsfbxg4a7s0485wsbq1kljkxq94in91l4z";
      type = "gem";
    };
    version = "2.0.4";
  };
  uglifier = {
    dependencies = ["execjs"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wgh7bzy68vhv9v68061519dd8samcy8sazzz0w3k8kqpy3g4s5f";
      type = "gem";
    };
    version = "4.2.0";
  };
  unf = {
    dependencies = ["unf_ext"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bh2cf73i2ffh4fcpdn9ir4mhq8zi50ik0zqa1braahzadx536a9";
      type = "gem";
    };
    version = "0.1.4";
  };
  unf_ext = {
    groups = ["default" "ext_notifications" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wc47r23h063l8ysws8sy24gzh74mks81cak3lkzlrw4qkqb3sg4";
      type = "gem";
    };
    version = "0.0.7.7";
  };
  unicode-display_width = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06i3id27s60141x6fdnjn5rar1cywdwy64ilc59cz937303q3mna";
      type = "gem";
    };
    version = "1.7.0";
  };
  webrick = {
    groups = ["default" "ext_msf"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1d4cvgmxhfczxiq5fr534lmizkhigd15bsx5719r5ds7k7ivisc7";
      type = "gem";
    };
    version = "1.7.0";
  };
  websocket = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dib6p55sl606qb4vpwrvj5wh881kk4aqn2zpfapf8ckx7g14jw8";
      type = "gem";
    };
    version = "1.2.9";
  };
  websocket-client-simple = {
    dependencies = ["event_emitter" "websocket"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0n7cjfg21lvszgr0w6w0c59qpwzpb7w4b3c7i3nxdpckabk76sx8";
      type = "gem";
    };
    version = "0.3.0";
  };
  xmlrpc = {
    dependencies = ["webrick"];
    groups = ["ext_msf"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xa79ry3976ylap38cr5g6q3m81plm611flqd3dwgnmgbkycb6jp";
      type = "gem";
    };
    version = "0.3.2";
  };
  xpath = {
    dependencies = ["nokogiri"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bh8lk9hvlpn7vmi6h4hkcwjzvs2y0cmkk3yjjdr8fxvj6fsgzbd";
      type = "gem";
    };
    version = "3.2.0";
  };
  zeitwerk = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1746czsjarixq0x05f7p3hpzi38ldg6wxnxxw74kbjzh1sdjgmpl";
      type = "gem";
    };
    version = "2.4.2";
  };
}
