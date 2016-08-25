//
//  ViewController.m
//  ApplePayPOC
//
//  Created by Ramirez, Antonio on 8/23/16.
//  Copyright © 2016 Ramirez, Antonio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,retain) PKPassLibrary * passLib;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  Method to validate that the device supports Wallet operations
-(BOOL)isWalletAvailable{
    return [PKAddPaymentPassViewController canAddPaymentPass];
}

//  Method to validate that the card we want to add is not already in the Wallet
-(BOOL)canAddCardToWallet: (NSString*)primaryAccountIdentifier{
    return [_passLib canAddPaymentPassWithPrimaryAccountIdentifier:primaryAccountIdentifier];
}

//  "Add card" button behavior
- (IBAction)initiateProvisioning:(id)sender {
    
    PKAddPaymentPassRequestConfiguration * passDetails = [[PKAddPaymentPassRequestConfiguration alloc] initWithEncryptionScheme:PKEncryptionSchemeECC_V2];
    passDetails.cardholderName = @"";
    passDetails.primaryAccountSuffix = @"";
    passDetails.localizedDescription = @"";
    passDetails.primaryAccountIdentifier = @"";
    passDetails.paymentNetwork = @"";
    
    PKAddPaymentPassViewController * passViewController = [[PKAddPaymentPassViewController alloc] initWithRequestConfiguration:passDetails delegate:self];
    [self presentViewController:passViewController animated:YES completion:nil];
}

//Delegate Callback #1
-(void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
generateRequestWithCertificateChain:(NSArray<NSData *> *)certificates
                              nonce:(NSData *)nonce
                     nonceSignature:(NSData *)nonceSignature
                  completionHandler:(void (^)(PKAddPaymentPassRequest * _Nonnull))handler{
    
    //Information we need to send to DCIS
    NSArray * certs = certificates; //Certificates
    NSData * n = nonce; // Nonce
    NSData * nSignature = nonceSignature; //Nonce Signature
    
    //Service call to DCIS here - It can be done using Grand Central Dispatch

    //Create PKAddPaymentPassRequest
    PKAddPaymentPassRequest * passrequest = [[PKAddPaymentPassRequest alloc] init];
    passrequest.encryptedPassData = @""; //this should be a NSDATA object hence the warning, entering an empty string temporarily
    passrequest.activationData = @""; //this should be a NSDATA object hence the warning, entering an empty string temporarily
    passrequest.ephemeralPublicKey = @""; //this should be a NSDATA object hence the warning, entering an empty string temporarily
    
}


//Delegate Callback #2
-(void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
         didFinishAddingPaymentPass:(PKPaymentPass *)pass
                              error:(NSError *)error{
    
    // The pass if provisioning was successful, nil otherwise.
    if(pass == nil){
        NSLog(@"Error: %@",error.localizedDescription);
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end