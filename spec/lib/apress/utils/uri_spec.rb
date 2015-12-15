# -*- encoding : utf-8 -*-

require File.expand_path('../../../../spec_helper', __FILE__)

describe Apress::Utils::Uri do

  strings1 = [ "http://e1.ru/",
            "ftp://ftp.e1.ru/",
            "http://lenta.ru/data.html",
            "http://lenta.ru/data/data.html",
            "http://giraf.ru/data/picture.jpg",
            "ftp://ftp.giraf.ru/datas/pictures/pict1.jpg",
            "ftp://ftp.giraf.ru/datas/pictures/pict2.jpg",
            "ftp://ftp.giraf.ru/datas/pictures/pict2(2).jpg",
  ]

  strings2 = [
    ["ftp://ftp.giraf.ru/data/pict (1).jpg" ,
     "ftp://ftp.giraf.ru/data/pict%20(1).jpg"
    ],
    ["ftp://мойсайт.рф/data/pict (1).jpg" ,
     "ftp://xn--80arbjktj.xn--p1ai/data/pict%20(1).jpg"
    ],
    ["ftp://giraf.ru/data/мои картинки/pict (1).jpg" ,
     "ftp://giraf.ru/data/%D0%BC%D0%BE%D0%B8%20%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8/pict%20(1).jpg"
    ],
    ["http://ujirafika.ru/images/products/large/1334396956_Велосипед Smart Trike Recliner 4 в 1 красный.jpg",
     "http://ujirafika.ru/images/products/large/1334396956_%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Smart%20Trike%20Recliner%204%20%D0%B2%201%20%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9.jpg"
    ],
    ["ftp://мойсайт.рф/data/мои картинки/pict (1).jpg" ,
     "ftp://xn--80arbjktj.xn--p1ai/data/%D0%BC%D0%BE%D0%B8%20%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8/pict%20(1).jpg"
    ],
    [ "http://лыжи.рф/image/cache/data/Accumulyator/CanonLP-E4.jpg-100x100.jpg",
      "http://xn--f1aeh8d.xn--p1ai/image/cache/data/Accumulyator/CanonLP-E4.jpg-100x100.jpg"
    ],
    [ "http://xn--80aqfls.xn--p1ai/dlya-audiovideofoto/akkumulyatory/canon/akkumulyator-%20%D0%B4%D0%BB%D1%8F%20%D0%BA%D0%B5%D0%BD%D0%BE%D0%BD%D0%B0%20-li-ion-canon-lp-e4.html",
      "http://xn--80aqfls.xn--p1ai/dlya-audiovideofoto/akkumulyatory/canon/akkumulyator-%20%D0%B4%D0%BB%D1%8F%20%D0%BA%D0%B5%D0%BD%D0%BE%D0%BD%D0%B0%20-li-ion-canon-lp-e4.html"
    ],
# это проверка для урл содержащих %C2%B2 он не должен изменять символы %C2%B2
    [ "http://domsantech.ru/Faucets/Hansgrohe/Faucets_Talis%20S%C2%B2_Hansgrohe/TalisS2_32040000.html",
      "http://domsantech.ru/Faucets/Hansgrohe/Faucets_Talis%20S%C2%B2_Hansgrohe/TalisS2_32040000.html"
    ],
# это проверка на 2 %C2%B2
    [ "http://domsantech.ru/Faucets/Hansgrohe/Faucets_Talis%20S%C2%B2_Hansgrohe/TalisS%C2%B2_32040000.html",
      "http://domsantech.ru/Faucets/Hansgrohe/Faucets_Talis%20S%C2%B2_Hansgrohe/TalisS%C2%B2_32040000.html"
    ]


  ]

  module CoreUriStubModule
    extend Apress::Utils::Uri
  end

  it "should raise exception" do
    url = "e1.ru"
    expect { CoreUriStubModule.encode_punycode(url) }.to raise_error(Apress::Utils::Uri::EncodeRusError)
    url = "e1.ru/data/"
    expect { CoreUriStubModule.encode_punycode(url) }.to raise_error(Apress::Utils::Uri::EncodeRusError)
    url = "ntp://e1.ru"
    expect { CoreUriStubModule.encode_punycode(url) }.to raise_error(Apress::Utils::Uri::EncodeRusError)
    url = "/path/to/picture/"
    expect { CoreUriStubModule.encode_punycode(url) }.to raise_error(Apress::Utils::Uri::EncodeRusError)
  end

  it "test 2" do
    strings1.each do |str|
      CoreUriStubModule.encode_punycode(str).should be == str
    end
  end

  pending "test 3" do
    strings2.each do |data|
      CoreUriStubModule.encode_punycode(data[0]).should be == data[1]
    end

  end

  describe '#add_params_to_url' do
    context 'when calling' do
      let(:http) { 'http://' }
      let(:https) { 'https://' }
      let(:url) { 'test.com' }

      context 'with url + params' do
        let(:add_params_to_url) { CoreUriStubModule.add_params_to_url(http << url << '/?id=123', 'param' => true) }

        it { expect(add_params_to_url).to eq 'http://test.com/?id=123&param=true' }
      end

      context 'with url' do
        let(:add_params_to_url) { CoreUriStubModule.add_params_to_url(http << url, 'param' => true) }

        it { expect(add_params_to_url).to eq 'http://test.com?param=true' }
      end

      context 'with not normalized url' do
        let(:add_params_to_url) { CoreUriStubModule.add_params_to_url(url, 'param' => true) }

        it { expect(add_params_to_url).to eq 'http://test.com?param=true' }
      end

      context 'with https schema' do
        let(:add_params_to_url) { CoreUriStubModule.add_params_to_url(https << url, 'param' => true) }

        it do
          expect(add_params_to_url).to eq 'https://test.com?param=true'
        end
      end

      context 'without params' do
        let(:add_params_to_url) { CoreUriStubModule.add_params_to_url(http << url) }

        it { expect(add_params_to_url).to eq 'http://test.com' }
      end
    end
  end
end