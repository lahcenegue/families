import 'package:flutter/material.dart';

import '../../../Utils/Constants/app_size.dart';

class UserTermsAndConditionsPage extends StatelessWidget {
  const UserTermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شروط وأحكام العملاء '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'مرحبًا بكم في تطبيق "مأكول"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSize.widthSize(20, context),
              ),
            ),
            SizedBox(height: AppSize.heightSize(10, context)),
            _buildParagraph('تاريخ السريان: فبراير 2024'),
            SizedBox(height: AppSize.heightSize(10, context)),
            _buildSectionTitle('[1] المقدمة'),
            _buildBulletPoint(
                '1.1. تقدم مؤسسة نجلاء علي الدبيان باعتبارها المالك والمشغّل لتطبيق "مأكول" والذي يعمل كمنصة وسيطة عبر الإنترنت بين الأسر المنتجة التي تعرض وتبيع الأكلات والوجبات الصحية وربطهم بالعملاء الذين يطلبون أو يشترون هذه المنتجات في نطاقهم الجغرافي، ويقتصر دور التطبيق على الوساطة والربط بين الأسر المنتجة والعملاء.'),
            _buildBulletPoint(
                '1.2. تحكُم هذه الشّروط والأحكام إلى جانب سياسة الخصوصيّة القواعد التي تحكم وصول العميل إلى تطبيق "مأكول"، ومن المهم قراءتها وفهمها جيدًا، لأنها تُحدِّد كافة الإرشاداتِ اللازمةِ لطريقة استخدام خدماتها.'),
            _buildBulletPoint(
                '1.3. بوصولك كعميل لتطبيق "مأكول" وإكمال تسجيلك حساب واستخدام التطبيق في طلب وشراء الأكلات والوجبات الصحية من الأسر المنتجة، فأنتَ تؤكّد لنا بأنّك قرأت وفهمت ووافقت على هذه الشّروط، إذا كنت لا توافق على هذه الشّروط، فالرجاء عدم استخدام خدمات التطبيق.'),
            _buildBulletPoint(
                '1.4. يحق لنا -وفقًا لتقديرنا الخاص- إجراء تعديلات على كل/أو أجزاء من هذه الشّروط في أيّ وقت، ويكون للتعديلات الجديدة نفس الأحكام والآثار القانونية للنسخة الحالية من هذه الشّروط. لذا ننصحك بمراجعة هذه الشّروط بانتظام للاطّلاع على أيّ تعديلات عليها، وستُصبح التعديلات سارية تلقائيًا بمجرد نشرها على هذه الصفحة.'),
            _buildSectionTitle('[2] التعريفات'),
            _buildParagraph(
                'يكون للكلمات التالية المعنى الموضّح قرين كل منها ما لم يقتضِ السياق خلاف ذلك: '),
            _buildBulletPoint(
                '2.1. "التطبيق": يُقصد به تطبيق "مأكول" لأنظمة Android و iOS.'),
            _buildBulletPoint(
                '2.2. "نحن" أو "ضمير المتكلم" أو "ضمير الملكية": يُقصد بها مؤسسة نجلاء علي الدبيان.'),
            _buildBulletPoint(
                '2.3. "الأسر المنتجة": يُقصد به كل من يُسجّل حساب في تطبيق "مأكول" بغرض عرض وبيع المنتجات.'),
            _buildBulletPoint(
                '2.4. "العميل": يُقصد به كل من يُسجّل حساب في تطبيق "مأكول" بغرض طلب وشراء المنتجات التي تعرضها الأسر المنتجة المُسجّلة في التطبيق، ويشار له بلفظ الجمع: "العملاء".'),
            _buildBulletPoint(
                '2.5. "المنتجات": يُقصد بها الأكلات والوجبات الصحية التي تعرضها الأسر المنتجة على تطبيق "مأكول".'),
            _buildBulletPoint(
                '2.6. "الطلب": يُقصد به الطلب الذي يقدمه العميل إلى الأسر المنتجة لشراء أحد المنتجات المعروضة في التطبيق.'),
            _buildBulletPoint(
                '2.7. "المحتوى": يُقصد به مُحتوى تطبيق "مأكول" ويشمل ذلك المعلومات، والبيانات، والنصوص، والصور، ومقاطع الفيديو، والصوت، والرسومات، والميزات التفاعليّة التي يتم توفيرها أو إتاحتها للمُستخدِم.'),
            _buildBulletPoint(
                '2.8. "حقوق الملكيّة الفكريّة": يُقصد بها كافة الحقوق المتعلقة بتطبيق "مأكول"، والتي تشمل على سبيل المثال لا الحصر الحقوق والأعمال البرمجيّة، حقوق المؤلّف، حقوق الطبع والنشر، براءة الاختراع، العلامات التّجارية -سواء مسجّلة أو غير مسجّلة-، اسم النطاق (بأيّ امتداد)، الشعارات، التصاميم، الرسومات، الاسم التّجاريّ، الرخصة التّجاريّة، وغيرها من الحقوق المقررة أو المرتبطة بالتطبيق سواء كان مسجّلة أو غير مسجّلة.'),
            _buildBulletPoint(
                '2.9. "القوة القاهرة": يُقصد بها أيّ حدث سواء كان مباشر أو غير مباشر أو ظرف خارج عن سيطرة الطرف الذي تأثر به، ويمنعه من تنفيذ أيّ أو جميع التزاماته التي تتجاوز السيطرة المعقولة.'),
            _buildBulletPoint(
                '2.10. "الأطراف الثالثة": يُقصد بها كافة الأشخاص والجهات الأخرى غير التابعة لنا والتي قد تشاركنا في تقديم الخدمات أو التي قد توفّر خدماتها من خلال تطبيق "مأكول"، أو التي قد تساهم في نشر أو استخدام خدماتنا.'),
            _buildBulletPoint(
                '2.11. "الشّروط والأحكام": يُقصد بها هذه الشّروط وسياسة الخصوصيّة وكافة تعليمات وقواعد تشغيل التطبيق.'),
            _buildBulletPoint(
                '2.12. "القوانين": يُقصد بها الأنظمة واللوائح والأوامر والمراسيم السارية في المملكة العربيّة السعوديّة.'),
            _buildSectionTitle('[3] الإقرارات والضمانات'),
            _buildParagraph(
                'باستخدامك (العميل) لخدمات تطبيق "مأكول"، فأنت تقر وتضمن:'),
            _buildBulletPoint(
                '3.1. بأنّ لديك كامل الأهلية المعتبرة شرعًا ونظامًا لإبرام هذه الشّروط والأحكام.'),
            _buildBulletPoint(
                '3.2. بأنّ وصولك إلى تطبيق "مأكول" أو استخدام أيّ من خدماته أو النقر على الموافقة على الشّروط والأحكام، يعتبر إقرارًا منك على إبرام هذه الشّروط والأحكام إلكترونيًا مع مؤسسة نجلاء علي الدبيان وفقًا للأنظمة المعمول بها في المملكة العربيّة السعوديّة.'),
            _buildBulletPoint(
                '3.3. بأنّك لن تحاول الوصول إلى التطبيق بوسائل آلية، سواء من خلال روبوت أو برنامج نصي أو غير ذلك.'),
            _buildBulletPoint(
                '3.4. بأنّك ستستخدم تطبيق "مأكول" على النحو المسموح به في هذه الشّروط وبما يتوافق مع القوانين المعمول بها، وأنك لن تستخدِم التطبيق في أغراض غير قانونية أو غير مصرح بها أو غير مسموح بها، وأنّ استخدامك لخدمات التطبيق لن ينتهك أيّ قانون أو لائحة معمول بها.'),
            _buildBulletPoint(
                '3.5. بأنّك المسؤول عن جميع التصرفات التي تجريها من خلال حسابك، وتبعات هذا الاستخدام.'),
            _buildSectionTitle('[4] نطاق خدمات التطبيق'),
            _buildBulletPoint(
                '4.1. يوفّر تطبيق "مأكول" للعملاء الخدمات التالية:'),
            _buildSubPoint(
                '4.1.1. تسجيل حساب مجاني، والاستفادة من المزايا التي يوفرها التطبيق.'),
            _buildSubPoint(
                '4.1.2. البنية التقنيّة لتوفير وتشغيل التطبيق بشكل آمن، ومركز الاتصال والدعم الفني.'),
            _buildSubPoint(
                '4.1.3. تصفح الأكلات والوجبات الصحية التي تعرضها الأسر المنتجة وفقًا لأقسام وتصنيفات التطبيق.'),
            _buildSubPoint(
                '4.1.4. تقديم طلبات شراء إلى الأسر المنتجة المُسجّلة في التطبيق.'),
            _buildSubPoint(
                '4.1.5. وسائل الدفع الإلكتروني التي تتناسب مع الجميع من خلال التعاقد مع مزوّدي خدمات المدفوعات.'),
            _buildBulletPoint(
                '4.2. باستخدامُك كعميل لخدمات تطبيق "مأكول" أو تسجيلُك حساب بعد النقر على زر أوافق على الشّروط والأحكام عند مطالبتك بذلك يعد توقيعًا إلكترونيًا على هذه الشّروط، وموافقة صريحة منك على الالتزام بجميع بنودها، وتكون هذه الشّروط واجبة النفاذ قانونًا من تاريخ تسجيلك حساب.'),
            _buildBulletPoint(
                '4.3. يعد تطبيق "مأكول" وسيلة لعرض المحتوى والخدمات الخاصة به وعرض منتجات الأسر المنتجة.'),
            _buildBulletPoint(
                '4.4. لا يتحمّل تطبيق "مأكول" المسؤوليّة عن عمليات الشراء أو التعامل بين الأسر المنتجة والعُملاء.'),
            _buildBulletPoint(
                '4.5. يحق لنا -حسب تقديرنا الخاص- تحديد المُحتوى، والمظهر، والتصميم، والأداء الوظيفي، وجميع الجوانب الأخرى المُتعلّقة بتطبيق "مأكول" وخدماته.'),
            _buildSectionTitle('[5] العقد الإلكتروني'),
            _buildBulletPoint(
                '5.1. تعد هذه الشّروط عقدًا إلكترونيًا صحيحًا مكتملاً الأركان القانونية بين مؤسسة نجلاء علي الدبيان وبينك (العميل) فيما يتعلق باستخدام خدمات تطبيق "مأكول"، وتكون كافة الآثار القانونيّة الملزمة فيها سارية المفعول من تاريخ تسجيلك حساب، وتصبح ملزمًا بها كالتزامك بالعقود المبرمة كتابيًا، وينتج عنها نفس الآثار القانونية لمثل هذه العقود.'),
            _buildBulletPoint(
                '5.2. عندما يطلب العميل أحد الأكلات او الوجبات الصحية من الأسر المنتجة التي تعرضها على تطبيق "مأكول"، فإن العميل يدخل في علاقة مباشرة وملزمة قانونًا مع الأسرة المنتجة، ويوافق العميل على إخلاء مسؤولية التطبيق من التعاملات التي تتم بينه وبين أي أسرة منتجة من خلاله، فالتطبيق ليس عميلاً يشتري أي من الأكلات أو الوجبات التي تعرضها الأسر المنتجة، ولا يتفاوض بشأنها أو أسعارها، وإنّما يقتصر دوره على الوساطة والربط الطرفين لإتمام التعاقد من خلاله ويتحمّل كل طرف مسؤولية التعاقد مع الطرف الآخر.'),
            _buildSectionTitle('[6] حساب العميل'),
            _buildBulletPoint(
                '6.1. يمكنك كعميل تسجيل حساب مجاني في تطبيق "مأكول" حسب شروط التسجيل.'),
            _buildBulletPoint('6.2. يجب على العميل:'),
            _buildSubPoint(
                '6.2.1. الموافقة على الشروط والأحكام، وتسجيل حساب بالاسم الحقيقي، وألا يستخدم اسم مستعار أو مجهول أو مضلل.'),
            _buildSubPoint(
                '6.2.2. تقديم بيانات كاملة ودقيقة وصحيحة كما هو مطلوب في نموذج التسجيل.'),
            _buildSubPoint(
                '6.2.3. تحرّي الدقة عند إدخال البيانات على تطبيق "مأكول"، ويكون مسئولاً عن مراجعة تلك البيانات بشكل دوري بغرض تصحيحها أو تعديلها أو تجديدها كلما توفّرت لديه بيانات جديدة بشأنها.'),
            _buildSubPoint(
                '6.2.4. الحفاظ على أمان وسرية بيانات الدخول للحساب (اسم المُستخدِم وكلمة المرور) طوال الوقت، وتحمُل مسؤوليّة أي استخدام يقع من أي شخص قمت بالإفصاح له عن هذه البيانات.'),
            _buildSubPoint(
                '6.2.5. تقييد الغير من استخدام الحساب، وتحمُل المسؤوليّة عن الأنشطة التي تحدث من خلاله.'),
            _buildSubPoint(
                '6.2.6. إبلاغ إدارة "مأكول" على الفور بأي استخدام غير قانونيّ للحساب أو أي اشتباه في استخدامه، وذلك لاتخاذ الإجراءات التقنيّة اللازمة للمحافظة على الحساب.'),
            _buildSubPoint(
                '6.2.7. استخدام الحساب بما يتوافق مع القوانين واللوائح السارية في المملكة العربيّة السعوديّة، وأن يلتزم بشروط وسياسات وقواعد وتعليمات تشغيل التطبيق.'),
            _buildSubPoint(
                '6.2.8. عدم الشروع بأي تصرف من شأنه إلحاق أي ضرر بشكل مباشر أو غير مباشر بنشاط التطبيق وأهدافه.'),
            _buildSubPoint(
                '6.2.9. عدم امتلاك أكثر من حساب واحد ما لم تسمح بذلك إدارة "مأكول".'),
            _buildBulletPoint(
                '6.3. يحقُ لنا تعليق أو إيقاف حساب العميل بشكلٍ دائمٍ حسب شدّة المُخالفة في حالة عدم الالتزام ببنود هذه الشّروط أو القواعد وإرشادات الاستخدام المُتبعّة، وقد نرسل للعميل تنبيهًا عبر البريد الإلكتروني المرتبط بحسابه يتعلق بانتهاك الشّروط والقوانين أو أي استخدام غير مناسب لخدمات التطبيق.'),
            _buildBulletPoint(
                '6.4. يحقُ لنا إلغاء الحسابات التي لم يتم تأكيدها أو غير النشطة لفترة طويلة.'),
            _buildBulletPoint(
                '6.5. يحقُ لنا التحقق من بيانات ومتطلبات التسجيل والمعلومات التي يقدمها لنا العميل، وبموجب هذه الشّروط يفوضنا العميل بجمع واستخدام وتخزين تلك المعلومات وفقًا لسياسة الخصوصيّة في التطبيق.'),
            _buildSectionTitle('[7] شروط العملاء'),
            _buildBulletPoint(
                '7.1. يجب على العميل تسجيل حساب بالاسم الحقيقي وبيانات صحيحة ودقيقة، وألا يستخدم اسم مستعار أو مجهول، وأن يتحمّل مسؤولية ذلك.'),
            _buildBulletPoint(
                '7.2. يقرُ ويتعهّد العميل بأنّ حسابه المسجّل في تطبيق "مأكول" حساب شخصي، ويتحمّل مسؤولية أيّ استخدام غير قانوني أو غير مسموح به، كما يتحمّل مسؤولية أيّ تواصل بينه وبين الأسر المنتجة.'),
            _buildBulletPoint(
                '7.3. يجب أن تتوافر في العميل الأهلية القانونية اللازمة لطلب وشراء المنتجات عبر الإنترنت.'),
            _buildBulletPoint(
                '7.4. يستطيع العميل تصفح منتجات الأسر المنتجة على تطبيق "مأكول"، وتقديم طلب شراء بعد الاطّلاع على وصف وصور المنتجات والاتفاق مع الأسر المنتجة على الطلب.'),
            _buildBulletPoint(
                '7.5. عند تقديم العميل طلباً لشراء أحد المنتجات التي تعرضها الأسر المنتجة في تطبيق "مأكول"، سنرسل إليه رسالة تأكيد عبر البريد الإلكتروني بقبول طلبه من قبل الأسرة المنتجة.'),
            _buildBulletPoint(
                '7.6. يلتزم العميل بسداد ثمن الطلب بإحدى طرق الدفع التي يوفرها تطبيق "مأكول"، وأيّ رسوم تتعلق بشراء الطلب، وستظهر هذه المبالغ في آخر خطوة أثناء تقديم طلب الشراء.'),
            _buildBulletPoint(
                '7.7. يجب على العميل استخدام بطاقاته البنكية أو الائتمانية، وعدم استخدام بطاقات مسروقة أو ليست ملكًا له.'),
            _buildBulletPoint(
                '7.8. يجب على العميل تقديم عنوان ورقم صحيح لتوصيل وتسليم الطلب.'),
            _buildBulletPoint(
                '7.9. يتحمل العميل مسؤولية صحة البيانات التي يقدمها في طلب الشراء، وفي حال اكتشف أنه أخطأ في بيانات الطلب بعد تقديمها، يمكنه التواصل مع خدمة عملاء تطبيق "مأكول" والإبلاغ بهذا الخطأ.'),
            _buildBulletPoint(
                '7.10. يقر العميل بأن تطبيق "مأكول" لا يقدم أيّ ضمانات بشأن الأكلات أو الوجبات التي تعرضها الأسر المنتجة.'),
            _buildBulletPoint(
                '7.11. يقر ويوافق العميل بأن تطبيق "مأكول" لا يمثله أمام الغير ولا يعتبر وكيلاً عن الأسر المنتجة، ولا يملك أي سلطة إشرافيه أو رقابية عليهم، وأنهم مستقلون تمامًا في تأدية عملهم، ويتحمّل العميل المسؤولية في مواجهة الأسر المنتجة في حالة الإخلال بهذه الشّروط، أو أي من الأنظمة القانونية المعمول بها.'),
            _buildBulletPoint(
                '7.12. يوافق العميل بأنّ تطبيق "مأكول" وسيط بينه وبين الأسرة المنتجة، وأن التطبيق يقتصر دوره على الربط التقني لإتمام الطلب، وبالتالي لا يتحمّل التطبيق أي مسؤولية تتعلق بالمنتجات سواء من حيث عدم مطابقتها للمواصفات أو جودتها أو أسعارها. وفي حال وجود أيّ شكوى من العميل بشأن هذه المنتجات، فإنه يتعيّن على العميل الرجوع على الأسرة المنتجة مباشرةً عن طريق التواصل معها أولاً وإبلاغها بشكواه وإيجاد حل لها، وفي حال عدم التوصّل إلى حل يتم رفع الشكوى إلى إدارة تطبيق "مأكول" للنظر في شكواه ومتابعة إجراءاتها مع الأسرة المنتجة.'),
            _buildSectionTitle('[8] وسائل الدفع'),
            _buildBulletPoint(
                '8.1. تحدد أسعار المنتجات في تطبيق "مأكول" بالعملة الوطنية (الريال السعودي).'),
            _buildBulletPoint(
                '8.2. يوفّر تطبيق "مأكول" الدفع الإلكتروني عن طريق بطاقات ابل باي، وفيزا، ومدى.'),
            _buildBulletPoint(
                '8.3. يجب على العميل التأكد من أنّ البيانات التي يدخلها أثناء عملية الدفع صحيحة ودقيقة وسارية المفعول، وفي حال استخدم بطاقة شخص آخر فيجب أن يكون لديه تفويض أو إذن باستخدامها.'),
            _buildBulletPoint(
                '8.4. عند الدفع بإحدى البطاقات، فيجب أن تحتوي البطاقة على رصيد كافي لتغطية عملية الشراء.'),
            _buildBulletPoint(
                '8.5. لن نتحمّل المسؤوليّة في حالة رفض عملية الدفع أو إلغائها من قبل بوابة الدفع لأيّ سببٍ كان، لذا يرجى مراجعة البنك التابع لبطاقتك الائتمانية لمعرفة سبب الرفض.'),
            _buildBulletPoint(
                '8.6. قد تفرض بوابات الدفع رسوم إداريّة عند الدفع، وتختلف هذه الرسوم حسب الوسيلة المستخدمة، وفي هذه الحالة أنت المسؤول الوحيد عن سداد هذه الرسوم دون أدنى مسؤولية علينا.'),
            _buildBulletPoint(
                '8.7. يتم تأمين بياناتك بشكل صحيح من خلال استخدام أحدث تقنيات الحماية الإلكترونيّة والتشفير SSL والتي تتوافق مع PCI DSS، ونؤكد بأننا لن نقوم بتخزين بيانات الدفع على أنظمتنا.'),
            _buildBulletPoint(
                '8.8. يحقُ لنا إضافة وسائل دفع جديدة مستقبلاً أو إلغاء أيّ وسيلة حالية، وسيتم إفادتك بذلك.'),
            _buildSectionTitle('[9] إلغاء الطلبات'),
            _buildBulletPoint(
                '9.1. باعتبار أن تطبيق "مأكول" لا يقدم خدمات ولا يبيع منتجات لأي عميل، وإنما يتم ذلك من خلال الأسر المنتجة، وهم مستقلون تمامًا في أداء عملهم، فيتم إتباع سياسة الاستبدال والاسترجاع التي تتبعها الأسر المنتجة.'),
            _buildBulletPoint(
                '9.2. يمكن للعميل إلغاء الطلب ما لم يتم قبوله أو معالجته من قبل الأسر المنتجة.'),
            _buildBulletPoint(
                '9.3. يحق للعميل إلغاء الطلب إذا تأخر توصيل الطلب لأكثر من ساعتين.'),
            _buildBulletPoint(
                '9.4. في حالة تسلم العميل لطلب، وتبين بعد ذلك أن الطعم غير جيد أو جودة الطعام سيئة، فإن الأسرة المنتجة تلتزم بتعويض العميل عن ذلك سواء بطلب آخر أو تخفيض على طلب آخر.'),
            _buildSectionTitle('[10] استرجاع المال'),
            _buildBulletPoint(
                '10.1. نسعى في تطبيق "مأكول" لإرضاء الجميع، وفي حالة وجود مشكلة تتعلق بأي طلب أو عدم رضى العميل عن الطلب، فيجب أن يتواصل مع خدمة العملاء عن طريق إرسال رسالة على البريد الإلكتروني المعتمد للتطبيق وسيتم النظر في المشكلة والعمل على حلها في أسرع وقت ممكن.'),
            _buildBulletPoint(
                '10.2. في حالة استلام العميل للطلب، وتبين أن الوجبة غير جيد أو في حالة فساد، فإن الأسرة المنتجة تلتزم بتعويض العميل عن ذلك سواء بطلب آخر أو تخفيض على طلب آخر.'),
            _buildBulletPoint(
                '10.3. يحق للعميل استرجاع كامل المبلغ في الحالات التالية:'),
            _buildSubPoint('10.3.1. في حالة عدم استلام العميل للطلب.'),
            _buildSubPoint('10.3.2. في حالة وصل للعميل لطلب غير صحيح.'),
            _buildSubPoint(
                '10.3.3. في حالة عدم توصيل الطلب إلى العميل في الوقت المحدد.'),
            _buildBulletPoint(
                '10.4. في حالة الموافقة على استرجاع المال، فسيقوم تطبيق "مأكول" بإرجاعه إلى نفس وسيلة الدفع التي استخدمها العميل خلال (15) يوم كحد أقصى. ومع ذلك قد تتطلب عملية معالجة استرجاع المبالغ وقت أطول حسب سياسات البنوك والجهات مصدرة البطاقات ومزودي خدمات الدفع الإلكتروني.'),
            _buildSectionTitle('[11] تراخيص الاستخدام'),
            _buildBulletPoint(
                '11.1. مع مراعاة الالتزام والامتثال لهذه الشّروط، نمنحك بصفتك عميل ترخيصًا شخصيًا محدودًا وغير حصري وغير قابل للتحويل وغير قابل للمُخالفة من أجل:'),
            _buildSubPoint(
                '11.1.1. تنزيل وتثبيت تطبيق "مأكول" على جوّالك للاستخدام الشخصي، وبما يتوافق مع هذه الشّروط.'),
            _buildSubPoint(
                '11.1.2. الوصول إلى التطبيق وخدماته والاطّلاع على محتواه والمعلومات والمواد ذات الصلة.'),
            _buildSubPoint(
                '11.1.3. استخدام التطبيق في طلب وشراء الأكلات والوجبات الصحية من الأسر المنتجة المُسجّلة.'),
            _buildBulletPoint(
                '11.2. لا يشمل الترخيص الممنوح لك أي حقوق ملكية في تطبيق "مأكول" أو جزء منه، أو أي خدمة مقدمة من خلاله، كما لا يشير هذا الترخيص بشكلٍ مباشر أو غير مباشر لوجود شراكة من أي نوع بيننا وبينك.'),
            _buildSectionTitle('[12] ضوابط الاستخدام'),
            _buildBulletPoint(
                '12.1. يحظر استخدام تطبيق "مأكول" بما يخالف هذه الشّروط. فلا يجوز القيام بأي مما يلي:'),
            _buildSubPoint(
                '12.1.1. استخدام أيّة وسيلة أو إجراء لاعتراض أو محاولة اعتراض التشغيل الصحيح للتطبيق، أو استخدام أيّ برنامج تم تصميمه لعرقلة، أو تلف، أو تدمير، أو تقييد وظيفة أيّ برنامج أو جهاز أو معدات اتصالات تتعلق أو ترتبط بالتطبيق.'),
            _buildSubPoint(
                '12.1.2. استخدام أيّ عمليات آلية لمعالجة، أو مراقبة، أو نسخ، أو استخراج أيّ صفحات موجودة على التطبيق.'),
            _buildSubPoint(
                '12.1.3. إجراء الهندسة العكسية، أو محاولة اكتشاف رمز المصدر، أو محاولة فك رموز، أو برمجة، أو تشفير أي من البرامج المستخدمة لتوفير التطبيق.'),
            _buildSubPoint(
                '12.1.4. منع أيّ مُستخدِم من استخدام التطبيق، أو انتحال شخصية أو صفة أيّ موظف أو ممثل للتطبيق.'),
            _buildSubPoint(
                '12.1.5. إرسال الرسائل غير المرغوب فيها أو البريد العشوائي أو الرسائل التي تدعم أنشطة غير قانونية.'),
            _buildSubPoint(
                '12.1.6. نشر أي محتوى غير قانوني يتضمن تمييزًا أو تشهيرًا أو إساءة أو قذف ضد أي فرد أو جهة أيًا كانت.'),
            _buildSubPoint(
                '12.1.7. نشر أي مادة تتنافى أو تتعارض مع حقوق الملكية الفكرية للآخرين.'),
            _buildSubPoint(
                '12.1.8. تحميل أو إدخال أو نقل أو بث أي مادة لا يحق لها نقلها بموجب أي قانون أو علاقة تعاقدية.'),
            _buildSubPoint(
                '12.1.9. العبث بالبيانات والمعلومات أو محاولة تعديل أو إتلاف أي إجراءات أمنية أو توثيقية.'),
            _buildSubPoint(
                '12.1.10. التدخل في طبيعة عمل التطبيق عن طريق نشر الفيروسات، أو البرامج الإعلانية، أو برامج التجسس، أو أي تقنيات أخرى مثل برامج الإلغاء الآلية، أو التعليمات البرمجية الضارة، أو الأساليب، أو التقنيات المماثلة التي قد تعطل أو تتدخل في تشغيله أو توفيره.'),
            _buildSubPoint(
                '12.1.11. محاولة استكشاف، أو فحص، أو اختبار نقاط الضعف في أيّ من الخوادم المتصلة بالتطبيق.'),
            _buildSubPoint(
                '12.1.12. انتهاك قوانين التأليف والنشر، أو العلامة التجارية، أو براءة الاختراع، أو قواعد البيانات، أو الإعلانات، أو أي من حقوق الملكية الفكرية التي تتعلق بنا أو بالغير.'),
            _buildBulletPoint(
                '12.2. يحق لتطبيق "مأكول" إنهاء استخدامك وإنهاء التراخيص الممنوحة لك في حالة عدم التزامك بهذا البند.'),
            _buildSectionTitle('[13] إخلاء المسؤولية القانونية'),
            _buildBulletPoint(
                '13.1. يتم توفير تطبيق "مأكول" وخدماته على أساس "كما هو متوفر" أو "كما هو متاح" دون أيّ ضمانات أو تعهدات من أيّ نوع، سواء كانت صريحة أو ضمنية فيما يتعلق بموثوقية الخدمات أو توقيتها أو جودتها أو ملاءمتها أو توافرها، أو خلوها من الأخطاء.'),
            _buildBulletPoint(
                '13.2. يوافق العميل على إخلاء مسؤولية تطبيق "مأكول" من الخسائر أو الأضرار سواء المباشرة أو غير المباشرة، أو التبعية، أو العرضية التي تنشأ عن:'),
            _buildSubPoint(
                '13.2.1. صحة أو دقة المعلومات التي توفرها الأسر المنتجة عن المنتجات التي يعرضونها على التطبيق.'),
            _buildSubPoint(
                '13.2.2. المعلومات أو المواد أو التوصيات التي تتعلق بالوجبات والأكلات التي تعرضها الأسر المنتجة.'),
            _buildSubPoint(
                '13.2.3. التواصل الخارجي أو التعاملات التي تتم بين العميل وبين الأسر المنتجة خارج تطبيق "مأكول".'),
            _buildSubPoint(
                '13.2.4. الخلافات التي تحدث بين العميل والأسر المنتجة فيما يتعلق بأي طلب.'),
            _buildSubPoint(
                '13.2.5. تأخُر الأسر المنتجة في تسليم الطلب، أو تعرض الطلب لأي ضرر أو تلوث أو فساد أثناء توصيله.'),
            _buildSubPoint(
                '13.2.6. الأمراض الناتجة عن تناول أي وجبة أو أكلة ملوّثة أو فاسدة.'),
            _buildSubPoint(
                '13.2.7. حالات التسمم الغذائي للعملاء من تناول الطعام.'),
            _buildBulletPoint(
                '13.3. لن نتحمّل المسؤوليّة بأي حال من الأحوال في حالات:'),
            _buildSubPoint(
                '13.3.1. العُطل، أو الانقطاع، أو التوقُف، أو الاضطراب، أو عدم التوافر (المؤقت و/أو الجزئي) للتطبيق.'),
            _buildSubPoint(
                '13.3.2. التقصير أو التأخر في الأداء متى كان ذلك ناتجًا عن القوة القاهرة، أو الظروف الطارئة التي تخرج عن نطاق السيطرة وكان من شأنها منع أو تأخير تقديم خدمات تطبيق "مأكول".'),
            _buildSubPoint(
                '13.3.3. الروابط الخارجية المُرتبطة بالتطبيق، ولا تُعَد هذه الروابط مُصادَقَةً منا عليها.'),
            _buildSubPoint(
                '13.3.4. الخدمات والميزات التي يقدمها الآخرين حتى لو تم الوصول إليها عن طريق تطبيق "مأكول".'),
            _buildSubPoint(
                '13.3.5. تقصيرك في الحفاظ على أمان وسرية وخصوصيّة بيانات الحساب.'),
            _buildBulletPoint(
                '13.4. لن نتحمّل المسؤولية عن أيّ خسارة أو ضرر ناتج عن أيّ فيروسات أو أيّ مواد أخرى ضارة قد تؤثر على أو تصيب جوالك، أو حاسوبك، أو الجهاز اللوحي، أو أي معدات أو برامج أو غيرها بسبب استخدامك لخدماتنا؛ أو تنزيلك للمحتوى، أو أيّ معلومات أو مواد من أي موقع أو منصّة أخرى مُرتبطة بتطبيق "مأكول".'),
            _buildBulletPoint(
                '13.5. نسعى لبذل قصارى جهدنا لضمان توافر تطبيق "مأكول" وخدماته للاستخدام على مدار الساعة، ولكن قد نقوم من وقت لآخر بإجراء تحديثات عليها بسبب أعمال التطوير، أو الصيانة الدوريّة، أو إصلاح المشكلات الفنيّة، أو ما شابه.'),
            _buildBulletPoint(
                '13.6. يقر العميل بأن تطبيق "مأكول" عبارة عن خدمة قائمة على الإنترنت، ويعلم ويوافق أن شبكة الإنترنت دائمًا ما تكون عرضة لفساد البيانات أو عدم توفرها أو تأخر ظهورها، وبالتالي لا نضمن أنّ الأعطال التقنيّة سيتم إصلاحُها، أو أن التطبيق أو خوادمه سيكون خاليًا من الفيروسات أو المكونات الضارة، كما يوافق على إعفائِنا من أيّ مسؤوليّة قانونيّة في حالة التوقف نتيجة ذلك.'),
            _buildSectionTitle(
                '[14] حقوق الملكيّة الفكريّة والعلامات التجاريّة'),
            _buildBulletPoint(
                '14.1. تحتفظ مؤسسة نجلاء علي الدبيان بجميع حقوق الملكيّة الفكريّة في تطبيق "مأكول" وكافة الحقوق المتعلقة به بما في ذلك على سبيل المثال لا الحصر حقوق التأليف والنشر، وبراءات الاختراع، وقاعدة البيانات، والمظهر التجاري، والأسماء والعلامات التجاريّة، وعلامات الخدمة، والشعارات، والكلمات، ورؤوس الصفحات، والحملات الإعلانية، والتصاميم، والشعارات، والأيقونات، والأعمال الفنية، والرسومات، والصور، والفيديو، ومواد الجرافيك، والنصوص، والخطوط، والبرامج، وملفات الصوت، والمواد الرقمية، والوثائق، والبيانات، والأشكال المُستخدَمة في توفير التطبيق، وهي محمية بموجب قوانين الملكيّة الفكريّة.'),
            _buildBulletPoint(
                '14.2. تحتفظ مؤسسة نجلاء علي الدبيان بجميع الحقوق في العلامات التجاريّة لتطبيق "مأكول"، سواء كانت مسجّلة أو غير مسجّلة، ولا يجوز إعادة إنتاجها أو استخدامها في أيّ وسيلة إعلانيّة دون إذن كتابي منا.'),
            _buildBulletPoint(
                '14.3. تحتفظ مؤسسة نجلاء علي الدبيان بجميع الحقوق في تطبيق "مأكول" وجميع الأجهزة والبرامج والعناصر الأخرى المُستخدَمة لتوفيرها، ويعدُ أي تقليد أو اقتباس لكل أو بعض ميزاته انتهاكًا لحقوق الملكيّة الفكريّة والتأليف والنشر، وسيتم اتخاذ كافة الإجراءات القانونية ضد مرتكب الانتهاكات المذكورة.'),
            _buildSectionTitle('[15] انتهاك الحقوق'),
            _buildBulletPoint(
                '15.1. يُمنع منعًا باتًا بأي شكلٍ من الأشكال بيع أو ترخيص أو تأجير أو تعديل أو نسخ أو استنساخ أو إعادة طبع أو تحميل أو إعلان أو نقل أو توزيع أو العرض بصورة علنيّة أو تحرير أو إنشاء أعمال مشتقة من أيّ مواد أو محتويات تطبيق "مأكول" دون إذن كتابي منا.'),
            _buildBulletPoint(
                '15.2. يُمنع منعًا باتًا انتهاك حقوق الملكيّة الفكريّة لتطبيق "مأكول" أو العلامات التجاريّة أو التصاميم أو محتوى التطبيق، أو محاولة التعديل عليها أو استخدامها في أي أغراض غير قانونيّة.'),
            _buildSectionTitle('[16] التعويض'),
            _buildParagraph(
                'يوافق العميل على تعويض مؤسسة نجلاء علي الدبيان والدفاع عنها وإبراء ذمتها ومسئوليتها بما في ذلك المسؤولين والمديرين والموظفين من أو ضد كافة الدعاوى، أو المطالبات، أو الغرامات، أو التكاليف، أو النفقات بما في ذلك الرسوم القانونيّة وأتعاب المحاماة التي تنشأ عن أو تتعلق بـ:'),
            _buildBulletPoint(
                '16.1. الادعاءات أو المطالبات الناتجة عن استخدامه لتطبيق "مأكول".'),
            _buildBulletPoint(
                '16.2. أي إهمال أو سوء سلوك من جانبه، أو سوء استخدامه لخدمات التطبيق بأي شكلٍ كان.'),
            _buildBulletPoint(
                '16.3. التصرف أو اتخاذ أي إجراء من شأنه الإضرار بالتطبيق أو سمعته أو توجهاته سواء بشكلٍ مباشر أو غير مباشر.'),
            _buildBulletPoint(
                '16.4. انتهاك أيًا من هذه الشّروط، أو قواعد وتعليمات تتعلق بتشغيل تطبيق "مأكول".'),
            _buildBulletPoint(
                '16.5. انتهاك حقوق الملكيّة الفكريّة وحقوق النشر والعلامات التجاريّة والخصوصيّة أو أي من القوانين السّارية.'),
            _buildSectionTitle('[17] الاتصالات الإلكترونية'),
            _buildBulletPoint(
                '17.1. يحق لنا التواصل معك من خلال البريد الإلكتروني المسجّل لدينا لتزويدك بالإعلانات أو فيما يتعلق بأي تحديثات حول هذه الشّروط أو سياسة الخصوصيّة، الخصوصيّة، أو النشرات الإخبارية، أو الإشعارات الفنية، أو تنبيهات الأمان، أو الرسائل الإدارية من تطبيق "مأكول"، أو لأغراض تسويقيّة، أو لإعلامك بأي ميزات أو أنشطة جديدة أو خدمات تضاف إلى التطبيق، أو وفقاً لما يقتضيه القانون، أو لأغراض أخرى وفقًا لتقديرنا الخاص، وإذا قررت في أيّ وقت عدم استلام مثل هذه الاتصالات الإلكترونية، فيمكنك تعطيل استلام هذه الرسائل عن طريق مراسلتنا عبر البريد الإلكتروني أو عن طريق النقر على رابط إلغاء الاشتراك الموجود أسفل الرسالة الإلكترونية، ولكن في هذه الحالة لا نضمن تمتعك بخدماتنا بشكل كامل.'),
            _buildBulletPoint(
                '17.2. أنت توافق على أن كل الاتصالات الإلكترونية تفي بجميع المتطلبات القانونية كما لو كانت هذه الاتصالات مكتوبة.'),
            _buildSectionTitle('[18] الرسائل و الإشعارات'),
            _buildBulletPoint(
                '18.1. أي إشعارات أو رسائل يرغب العميل في إرسالها إلى تطبيق "مأكول"، يجب أن تكون من خلال الوسائل المحددة في التطبيق، ولا يعتد بأي رسائل أو إشعارات أخرى غير ما هو محدد.'),
            _buildBulletPoint(
                '18.2. أي إشعارات أو رسائل نرسلها إلى العميل، تكون إما عن طريق التطبيق أو عن طريق إرسالها على البريد الإلكتروني المسجّل في حساب العميل.'),
            _buildSectionTitle('[19] السرية وحماية البيانات'),
            _buildBulletPoint(
                '19.1. يستخدم تطبيق "مأكول" البيانات الشخصيّة بالطريقة الموضحة في سياسة الخصوصيّة والتي تعتبر جزءًا لا يتجزأ من الشّروط والأحكام، وعلى النحو المبين بمزيد من التفصيل في تلك السياسة.'),
            _buildBulletPoint(
                '19.2. عند استخدام تطبيق "مأكول"، فأنت تُقر وتوافق على جمع واستخدام بياناتك الشخصيّة بالطريقة المبينة في سياسة الخصوصيّة أو التعديلات التي تطرأ عليها بما يتناسب مع القوانين السّارية.'),
            _buildSectionTitle('[20] المدة والإنهاء'),
            _buildBulletPoint(
                '20.1. تدخل هذه الشروط حيز التنفيذ من تاريخ تسجيل حساب والإقرار بقبولك لها وستظل سارية المفعول حتى يتم إنهاؤها من قبلك أو من قبلنا.'),
            _buildBulletPoint(
                '20.2. يجوز لنا وفقًا لتقديرنا المطلق إنهاء أو تقييد أو إيقاف حقك في الوصول إلى تطبيق "مأكول" واستخدام خدماته في أيّ وقت دون إشعار، في حال انتهكت أيًا من هذه الشّروط أو سياسة الخصوصيّة، أو أنّك أسأت استخدامه بأي شكل، أو ارتكبت أي سلوك آخر قد نعتبره حسب تقديرنا الخاص غير قانوني أو بالآخرين.'),
            _buildBulletPoint(
                '20.3. يجوز لك إنهاء هذه الشّروط في أيّ وقت عن طريق التوقف عن استخدام خدمات تطبيق "مأكول" وإلغاء الحساب -في حال توفر ذلك؛ وفي حالة الإنهاء ستتوقف كافة التراخيص الممنوحة لك بموجب هذه الشّروط، ولن يكون مصرحًا لك بالوصول إلى التطبيق.'),
            _buildSectionTitle('[21] تعديلات الشّروط'),
            _buildBulletPoint(
                '21.1. يحق لنا مراجعة وتعديل بنود هذه الشّروط من وقت لآخر لملاءمة القوانين السارية أو متى رأت المصلحة ذلك، وستسري النسخة المعدّلة فور نشرها على هذه الصفحة وتحديث تاريخ السريان.'),
            _buildBulletPoint(
                '21.2. يحق لنا إجراء أية تعديلات نراها ضرورية على تطبيق "مأكول" لزيادة فاعليته، ويلتزم العميل بأية توجيهات أو تعليمات تقدّم إليه في هذا الشأن.'),
            _buildBulletPoint(
                '21.3. أنت توافق على مراجعة هذه الشّروط لمعرفة التعديلات التي تتم عليها، ويعني استمرارك في استخدام تطبيق "مأكول" بعد تحديث هذه الشّروط موافقة صريحة على هذه التعديلات وقبولاً قانونيًا بالنسخة الأحدث منها، وأنّ النسخة الحالية حلت محل جميع النسخ السابقة.'),
            _buildSectionTitle('[22] القوانين والاختصاص القضائي'),
            _buildBulletPoint(
                '22.1. تخضع وتفسر هذه الشّروط وفقًا للقوانين المعمول بها في المملكة العربيّة السعوديّة.'),
            _buildBulletPoint(
                '22.2. يختص القضاء السعودي بالفصل في أي نزاع قد ينشأ عن تفسير أو تنفيذ أحكام هذه الشروط.'),
            _buildBulletPoint(
                '22.3. في حال أصبح أي حكم من أحكام هذه الشّروط غير ساري أو غير قانوني أو غير قابل للتنفيذ، فان قانونية وقابلية تنفيذ الأحكام الأخرى لن تتأثر بأي طريقة كانت بذلك الحكم.'),
            _buildSectionTitle('[23] أحكام أخرى'),
            _buildBulletPoint(
                '23.1. يحق لنا تحويل كافة حقوقنا الواردة في هذه الشّروط إلى أي طرف ثالث دون أيّ اعتراض منك بشرط أن يوافق هذا الطرف الثالث على الالتزام بهذه الشّروط.'),
            _buildBulletPoint(
                '23.2. لا يُفسر استخدامك لتطبيق "مأكول" على أنه يشكل علاقة شراكة، أو توظيف، أو وكالة، أو مشروع مشترك بين مؤسسة نجلاء علي الدبيان وبينك.'),
            _buildBulletPoint(
                '23.3. كتبت هذه الشّروط باللغةِ العربيّة، وفي حال ترجمتُها إلى لغةٍ أجنبيّةٍ أخرى، فإن النص العربيّ سيكون هو المعتمد.'),
            _buildBulletPoint(
                '23.4. في حال تعارضت هذه الشّروط مع أيّ من إصدارات سابقة لها، فإنّ النُسخة الحالية تكون هي السائدة والمعتمدة.'),
            _buildBulletPoint(
                '23.5. تشكل هذه الشّروط وسياسة الخصوصيّة (وتحديثاتها من حين لآخر) الاتفاق الكامل بينك (العميل) وبين مؤسسة نجلاء علي الدبيان فيما يتعلق باستخدام تطبيق "مأكول" وخدماتها، وتحل محل أي إصدارات سابقة من هذه الشّروط.'),
            _buildBulletPoint(
                '23.6. يقر ويتعهّد العميل بقراءة هذه الشّروط ويوافق على الالتزام بجميع أحكامها.'),
            _buildSectionTitle('[24] معلومات التواصل'),
            _buildParagraph(
                'إذا كانت لديك أيّ أسئلة أو استفسارات حول هذه الشروط، فلا تتردد في التواصل معنا على البريد الإلكتروني _________ أو رقم الهاتف ___________.'),
            _buildParagraph(' جميع الحقوق محفوظة لتطبيق "مأكول" © 2024.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFd9d9d9),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("   -  ", style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
