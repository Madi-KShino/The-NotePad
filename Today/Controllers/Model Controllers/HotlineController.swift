//
//  HotlineController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation


class HotlineController {
    
    //Singleton
    static let sharedInstance = HotlineController()
    
    //Hotline Categories
    var abuseHotlines: [Hotline] = []
    var suicideHotlines: [Hotline] = []
    var lgbtqHotlines: [Hotline] = []
    var otherHotlines: [Hotline] = []
    
    //Hotline Data
    let domesticAbuseHL = Hotline(name: "National Domestic Violence Hotline", number: "1-800-799-7233", textNumber: nil, website: "https://www.thehotline.org/help/help-for-friends-and-family/")
    let rainnHL = Hotline(name: "RAINN (Rape, Sexual Assault, Abuse, and Incest National Network)", number: "1-800-656-4673", textNumber: nil, website: "https://www.rainn.org/about-national-sexual-assault-telephone-hotline")
    let childhelpHL = Hotline(name: "Childhelp National Child Abuse Hotline", number: "1-800-422-4453", textNumber: nil, website: "http://www.childhelp.org/hotline/")
    
    let suicideHL = Hotline(name: "Suicide Prevention Lifeline", number: "1-800-273-8255", textNumber: nil, website: "https://suicidepreventionlifeline.org/talk-to-someone-now/")
    let safeHL = Hotline(name: "S.A.F.E. (Self Abuse Finally Ends)", number: "1-800-366-8288", textNumber: nil, website: "https://selfinjury.com/")
    
    let lgbtqHL = Hotline(name: "LGTB National Hotline", number: "1-888-843-4564", textNumber: nil, website: "http://www.glbtnationalhelpcenter.org/")
    let youthHL = Hotline(name: "Youth Talkline", number: "1-800-246-7743", textNumber: nil, website: nil)
    let seniorHL = Hotline(name: "Senior Helpline", number: "1-888-234-7243", textNumber: nil, website: nil)
    
    let womensLawHL = Hotline(name: "Womens Law Email Hotline", number: nil, textNumber: nil, website: "https://hotline.womenslaw.org/")
    let traffickingHL = Hotline(name: "National Human Trafficking Hotline", number: "1-888-373-7888", textNumber: "TEXT: 233733", website: "https://humantraffickinghotline.org/")
    let runawayHL = Hotline(name: "National Runaway Safeline", number: "1-800-786–2929", textNumber: nil, website: "https://www.1800runaway.org/")
    let teenDatingHL = Hotline(name: "Love is Respect - National Teen Dating Abuse Hotline", number: "1-866-331-9474", textNumber: "TEXT: LOVEIS to 22522", website: "https://www.loveisrespect.org/")

    //Add Hotlines to Categories
    func loadHotlineData(completion: @escaping (Bool) -> Void) {
        abuseHotlines = [domesticAbuseHL, rainnHL, childhelpHL]
        suicideHotlines = [suicideHL, safeHL]
        lgbtqHotlines = [lgbtqHL, youthHL, seniorHL]
        otherHotlines = [womensLawHL, traffickingHL, runawayHL, teenDatingHL]
    }
}
