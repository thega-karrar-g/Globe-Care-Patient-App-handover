class AboutModel {
  int id = 1;

  String titleAr = '', titleEn = '', descriptionAr = '', descriptionEn = '';

  AboutModel(
      {this.id = 1,
      this.titleAr = '',
      this.titleEn = '',
      this.descriptionAr = '',
      this.descriptionEn = ''});

  static List<AboutModel> aboutList = [
    AboutModel(
        id: 1,
        titleAr: 'نبذة عنا',
        titleEn: 'About Us',
        descriptionAr: 'جلـوب كير (Globcare):'
            '\n'
            ''
            'شــركة ســعودية متخصصــة فــي تقديــم الرعايــة الطبيــة المنزليــة والطــب الإتصالــي '
            'بمعاييــر عالميــة والقائمــة علــى أكفــأ الخبــرات الطبيــة فــي المجــال الصحــي.'
            '       ٌ فــي جلــوب كيــر يقــدم خبراؤنــا ومختصونــا الرعايــة الطبيــة المتكاملــة لمرضانــا أينمــا'
            '  كانــوا، حيــث نحــرص علــى تقديــم أعلــى مســتويات الجــودة بالخدمــات المقدمــة فــي'
            ' التشــخيص والعــاج والمتابعــة بمختلــف التخصصــات.'
            ''
            ''
            ''
            '',
        descriptionEn: ""
            "Globcare \n"
            "A Saudi company specialized in providing home medical care and telemedicine. International standards and based on the most efficient medical expertise in the health field. "
            "At Globe Care, our experts and specialists provide integrated medical care to our patients wherever they are, as we are keen to provide the highest quality services provided in the fields of diagnosis, treatment and follow-up in various specialties."
            ""),

    AboutModel(
        id: 1,
        titleAr: 'رســالتنا',
        titleEn: 'Our Message',
        descriptionAr: 'توفيـر حلـول طبيـة موثوقـة ومبتكـرة لحيـاة صحية.',
        descriptionEn:
            'Providing reliable and innovative medical solutions for a healthy life'),

    AboutModel(
        id: 1,
        titleAr: 'رؤيتنا',
        titleEn: 'Our Vision',
        descriptionAr: ''
            ' أن نكـون معيـارا لتقديـم الخدمـات الطبيـة المنزليـة والطـب الإتصالـي فـي المنطقـة.',
        descriptionEn:
            'To be a standard for providing home medical services and telemedicine in the region.'),

    AboutModel(
        id: 1,
        titleAr: 'قيمنا',
        titleEn: 'Our Value',
        descriptionAr: ''
            '- الإبتكار'
            '- المسـؤولية'
            '- التمحـور حـول العميل'
            '- الكفاءة'
            '',
        descriptionEn: '- Innovation\n'
            '- Responsibility\n'
            '- Customer centric\n'
            '- Efficiency'
            ''),

//     AboutModel(id: 1,titleAr: 'مهمتنا',titleEn: 'Our mission',descriptionAr:
// 'تسهيل وصول كافة الخدمات الصحية لكافة افراد المجتمع بأعلى معايير الجودة ومنح المريض مطلق الحرية في اختيار مقدمي الرعاية الصحية في أي وقت ومن أي مكان.'   ,descriptionEn: 'تسهيل وصول كافة الخدمات الصحية لكافة افراد المجتمع بأعلى معايير الجودة ومنح المريض مطلق الحرية في اختيار مقدمي الرعاية الصحية في أي وقت ومن أي مكان.' ),
//
//     AboutModel(id: 1,titleAr: 'هدفنا',titleEn: 'Our Goal',
//         descriptionAr:
//         '•	رفع مستوى الخدمات الصحية بما يتوافق مع اعلى معايير الجودة'
//             '\n'
//
//             '•	ضمان رضا المريض وراحته'
//             '\n'
//
//             '•	الوصول للخدمات الطبية بطريقة أسرع'
//             '\n'
//
//             '•	نشر ثقافة الرعاية الطبية عن بعد في المجتمع'
//
//         ,descriptionEn:
//         '•	رفع مستوى الخدمات الصحية بما يتوافق مع اعلى معايير الجودة'
//         '\n'
//             '•	ضمان رضا المريض وراحته'
//             '\n'
//
//             '•	الوصول للخدمات الطبية بطريقة أسرع'
//             '\n'
//
//             '•	نشر ثقافة الرعاية الطبية عن بعد في المجتمع'
//
//     ),
    AboutModel(
        id: 1,
        titleAr: 'العنوان',
        titleEn: 'Address',
        descriptionAr:
            'المملكة العربية السعودية- الرياض- طريق الامام سعود بن عبد العزيز- مركز الحياة. ',
        descriptionEn:
            'Kingdom of Saudi Arabia - Riyadh - Imam Saud bin Abdulaziz Road - Al-Hayat Center'),
  ];

  static List<AboutModel> faqList = [
    AboutModel(
        id: 1,
        titleAr:
            ' How does Google protect my privacy and keep my information secure?',
        titleEn:
            'How does Google protect my privacy and keep my information secure?',
        descriptionAr:
            'We know security and privacy are important to you – and they are important to us, too. We make it a priority to provide strong security and give you confidence that your information is safe and accessible when you need it.'
            '',
        descriptionEn: ''
            'We know security and privacy are important to you – and they are important to us, too. We make it a priority to provide strong security and give you confidence that your information is safe and accessible when you need it.'),
    AboutModel(
        titleAr:
            "How can I remove information about myself from Google's search results?",
        titleEn:
            "How can I remove information about myself from Google's search results?",
        descriptionAr:
            'Google search results are a reflection of the content publicly available on the web. Search engines can’t remove content directly from websites, so removing search results from Google wouldn’t remove the content from the web.',
        descriptionEn:
            'Google search results are a reflection of the content publicly available on the web. Search engines can’t remove content directly from websites, so removing search results from Google wouldn’t remove the content from the web.'),
    AboutModel(
        titleAr:
            'Are my search queries sent to websites when I click on Google Search results?',
        titleEn:
            'Are my search queries sent to websites when I click on Google Search results?',
        descriptionAr:
            'In some cases, yes. When you click on a search result in Google Search, your web browser also may send the Internet address, or URL, of the search results page to the destination webpage as the Referrer URL.',
        descriptionEn:
            'In some cases, yes. When you click on a search result in Google Search, your web browser also may send the Internet address, or URL, of the search results page to the destination webpage as the Referrer URL.'),
  ];

  static List<AboutModel> responsibilitiesList = [
    AboutModel(
      id: 1,
      titleAr:
          ' مسؤوليات المريض هي التعليمات التي يجب أن يتبعها المرضى وعائلاتهم. ',
      titleEn:
          ' مسؤوليات المريض هي التعليمات التي يجب أن يتبعها المرضى وعائلاتهم.',
      descriptionAr: ''
          '•	الاطلاع على احكام وشروط GlobCare   وتطبيقها بما يتماشى مع القوانين في المملكة العربية السعودية'
          '\n'
          '•	اتباع القواعد والتعليمات.'
          '\n'
          '•	تقديم الهوية الشخصية.'
          '\n'
          '•	تنفيذ التوصيات الطبية المعطاة لك كمريض من قبل الطبيب بعد مناقشتك للطبيب واقتناعك بها.'
          '\n'
          '•	ضرورة إعطاء معلومات كاملة ودقيقة عن المرض الحالي وكل ما يتعلق بتاريخك الصحي السابق.'
          '\n'
          '•	إخبار الطبيب بأي خطورة صحية تعلم بها قد تحدث بشكل مفاجئ أو غير متوقع.'
          '\n'
          '•	الإبلاغ عن أي تغييرات في صحة المريض.'
          '\n'
          '•	إبلاغ مقدمي الرعاية الصحية للعمليات الجراحية التي مر بها بالإضافة إلى المرافق الصحية الأخرى التي ذهب إليها.'
          '\n'
          '•	إخطار الطبيب عن عدم فهم خطة العلاج والتدخلات.'
          '\n'
          '•	توفير معلومات دقيقة وكاملة عن التأمين الصحي للمريض.'
          '\n'
          '•	اتباع خطة العلاج الموصي بها، حيث يكون المريض أو الوصي القانوني مسؤولاً عن أفعاله وعن العواقب في حال رفضه العلاج.'
          '\n'
          '•	اتباع القواعد العامة بالإضافة إلى احترام القيم، والمعتقدات الثقافية، والروحية، والشخصية.'
          '\n'
          '•	شفاء(العربية) يُدين أياً من أشكال العنف ضد مقدمي الخدمات الصحية من التلفظ بألفاظ مهينة. هذه الأفعال بمثابة اختراق لحق وشرف مقدم الخدمة الصحية.'
          '\n'
          '•	نلتزم أنا المريض وعائلتي بعدم استخدام أي وسيلة صوتية أو مرئية أو فيديو يظهر أحد الاطباء دون إذن مسبق، أو التشهير بشكل مباشر أو غير مباشر بالأطباء في إحدى وسائل التواصل، وأي خرق لهذه التعليمات سيعرِّض الفاعل للمسألة القانونية، ومن حق الشركة اتخاذ الإجراءات اللازمة.'
          ''
          '',
      descriptionEn: ''
          '•	الاطلاع على احكام وشروط GlobCare   وتطبيقها بما يتماشى مع القوانين في المملكة العربية السعودية'
          '\n'
          '•	اتباع القواعد والتعليمات.'
          '\n'
          '•	تقديم الهوية الشخصية.'
          '\n'
          '•	تنفيذ التوصيات الطبية المعطاة لك كمريض من قبل الطبيب بعد مناقشتك للطبيب واقتناعك بها.'
          '\n'
          '•	ضرورة إعطاء معلومات كاملة ودقيقة عن المرض الحالي وكل ما يتعلق بتاريخك الصحي السابق.'
          '\n'
          '•	إخبار الطبيب بأي خطورة صحية تعلم بها قد تحدث بشكل مفاجئ أو غير متوقع.'
          '\n'
          '•	الإبلاغ عن أي تغييرات في صحة المريض.'
          '\n'
          '•	إبلاغ مقدمي الرعاية الصحية للعمليات الجراحية التي مر بها بالإضافة إلى المرافق الصحية الأخرى التي ذهب إليها.'
          '\n'
          '•	إخطار الطبيب عن عدم فهم خطة العلاج والتدخلات.'
          '\n'
          '•	توفير معلومات دقيقة وكاملة عن التأمين الصحي للمريض.'
          '\n'
          '•	اتباع خطة العلاج الموصي بها، حيث يكون المريض أو الوصي القانوني مسؤولاً عن أفعاله وعن العواقب في حال رفضه العلاج.'
          '\n'
          '•	اتباع القواعد العامة بالإضافة إلى احترام القيم، والمعتقدات الثقافية، والروحية، والشخصية.'
          '\n'
          '•	شفاء(العربية) يُدين أياً من أشكال العنف ضد مقدمي الخدمات الصحية من التلفظ بألفاظ مهينة. هذه الأفعال بمثابة اختراق لحق وشرف مقدم الخدمة الصحية.'
          '\n'
          '•	نلتزم أنا المريض وعائلتي بعدم استخدام أي وسيلة صوتية أو مرئية أو فيديو يظهر أحد الاطباء دون إذن مسبق، أو التشهير بشكل مباشر أو غير مباشر بالأطباء في إحدى وسائل التواصل، وأي خرق لهذه التعليمات سيعرِّض الفاعل للمسألة القانونية، ومن حق الشركة اتخاذ الإجراءات اللازمة.'
          ''
          '',
    )
  ];
}
