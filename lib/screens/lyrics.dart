import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:html/parser.dart';

class LyricsScreen extends StatelessWidget {
  LyricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const htmlData = """
      <p>[Intro]<br> Ah<br> Ah, oh, oh-oh, oh<br> <br> [Verse 1: Stacey]<br> Ikaw ay nasilayan<br> Sa 'di inakalang panahon<br> Lumapit nang biglaan<br> Para bang 'di nagkataon<br> Ito nga ba'y tadhana?<br> Tangi kong hiling sa mga tala<br> Mga pintig ng puso'y<br> Nakalaan para sa'yo<br> <br> [Pre-Chorus: Mikha, <i>Jhoanna</i>]<br> From following your footprints in the sand<br> To walking with you on this island<br> Guided by the grip of your hand<br> I can feel you're holding my world<br> <a href="/31603961/Bini-pantropiko/Ano-ba-itong-nadarama" data-id="31603961" data-editorial-state="pending" data-classification="unreviewed"><i>Ano ba itong nadarama?</i></a><br> <i>Oh, shocks, ito ba'y pag-ibig na?</i><br> Totoo ba ang pinadama?<br> 'Cause boy, it feels so good<br> <br> [Chorus: Maloi, <i>Colet</i>]<br> <a href="/31603987/Bini-pantropiko/Bawat-araw-mas-sumasaya-magmula-nang-nakita-ka-nawawalan-ng-pangangamba-pag-ikay-kapiling-na" data-id="31603987" class="has_pending_edits" data-editorial-state="pending" data-classification="unreviewed">Bawat araw, mas sumasaya<br> Magmula nang nakita ka<br> Nawawalan ng pangangamba<br> 'Pag ika'y kapiling na</a><br> <i>Feels like summer when I'm with you<br> Parang islang pantropiko<br> Can't wait to go back with you<br> Sa islang pantropiko</i><br> <br> [Post-Chorus: All, <i>Maloi</i>, <b>Colet</b>]<br> <a href="/31603993/Bini-pantropiko/Pantropiko-pantropiko-oh-sa-islang-pantropiko-pantropiko-pantropiko-oh-sa-islang-pantropiko" data-id="31603993" data-editorial-state="pending" data-classification="unreviewed">Pantropiko, pantropiko, oh<br> <i>Sa islang pantropiko</i><br> Pantropiko, pantropiko, oh<br> <b>Sa islang pantropiko</b></a><br> <br> [Verse 2: Gwen]<br> Sumapit na ang araw<br> Nang ika'y muling nakausap<br> Hinahanap ka sa tabi<br> 'Di na mawala sa isip<br> Nakita kang papalapit<br> Puso ko'y bigla nang 'di mapakali<br> Ano nga ba'ng sinapit?<br> Kakapit ba hanggang huli?<br> <br> [Pre-Chorus: Aiah, <i>Sheena</i>]<br> From following your footprints in the sand<br> To walking with you on this island<br> Guided by the grip of your hand<br> I can feel you're holding my world<br> <i>Ano ba itong nadarama?<br> Oh, shocks, ito ba'y pag-ibig na?<br> Totoo ba ang pinadama?<br> 'Cause boy, it feels so good</i><br> <br> [Chorus: Stacey, <i>Jhoanna</i>]<br> Bawat araw, mas sumasaya<br> Magmula nang nakita ka<br> Nawawalan ng pangangamba<br> 'Pag ika'y kapiling na<br> <i>Feels like summer when I'm with you<br> Parang islang pantropiko<br> Can't wait to go back with you<br> Sa islang pantropiko</i><br> <br> [Post-Chorus: All, <i>Stacey</i>, <b>Jhoanna</b>]<br> Pantropiko, pantropiko, oh<br> <i>Sa islang pantropiko</i><br> Pantropiko, pantropiko, oh<br> <b>Sa islang pantropiko</b><br> <br> [Bridge: Mikha, <i>Colet</i>]<br> On this tropical island sitting on the white sand<br> Guess I found my love with you<br> 'Cause with you, boy, I'm going crazy<br> You could be my baby, I could be your lady (Oh, oh, oh-oh)<br> <i>'Di na maawatan ang kilig na bigay riyan<br> Puso'y parang bang 'di na mapigilan<br> Kumakabog o humihinto?<br> Gumugulo ang puso ko sa'yo</i><br> <br> [Pre-Chorus: Gwen, <i>Maloi</i>]<br> From following your footprints in the sand<br> To walking with you on this island<br> Guided by the grip of your hand<br> I can feel you're holding my world<br> <a href="/31436452/Bini-pantropiko/Ano-ba-itong-nadarama-oh-shocks-ito-bay-pag-ibig-na-totoo-ba-ang-pinadama-cause-boy-it-feels-so-good" data-id="31436452" data-editorial-state="pending" data-classification="unreviewed"><i>Ano ba itong nadarama?<br> Oh, shocks, ito ba'y pag-ibig na?<br> Totoo ba ang pinadama?<br> 'Cause boy, it feels so good</i></a><br> <br> [Chorus: Sheena, <i>Aiah</i>]<br> Bawat araw, mas sumasaya<br> Magmula nang nakita ka<br> Nawawalan ng pangangamba<br> 'Pag ika'y kapiling na (Kapiling na)<br> <i>Feels like summer when I'm with you<br> Parang islang pantropiko<br> Can't wait to go back with you (Ooh)<br> Sa islang pantropiko</i><br> <br> [Post-Chorus: All, <i>Maloi</i>, <b>Jhoanna</b>]<br> Pantropiko, pantropiko, oh<br> <i>Sa islang pantropiko</i><br> Pantropiko, pantropiko, oh<br> <b>Sa islang pantropiko</b> (Ooh, ooh)</p>
    """;

    var document = parse(htmlData.replaceAll("<br>", "\n\n"));
    String textContent = document.body!.text; // Extract text content

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "GigLyric",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(24),
              const Text(
                'Pantropiko',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Gap(24),
              Text(
                textContent,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
