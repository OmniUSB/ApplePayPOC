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

-(BOOL)isWalletAvailable{
    return [PKAddPaymentPassViewController canAddPaymentPass];
}

-(BOOL)canAddCardToWallet: (NSString*)primaryAccountIdentifier{
    return [_passLib canAddPaymentPassWithPrimaryAccountIdentifier:primaryAccountIdentifier];
}

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

-(void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
generateRequestWithCertificateChain:(NSArray<NSData *> *)certificates
                              nonce:(NSData *)nonce
                     nonceSignature:(NSData *)nonceSignature
                  completionHandler:(void (^)(PKAddPaymentPassRequest * _Nonnull))handler{
    
    NSArray * certs = certificates; //Certificates
    NSData * n = nonce; // Nonce
    NSData * nSignature = nonceSignature; //Nonce Signature
    
    //Service call here

    //Create PKAddPaymentPassRequest
    PKAddPaymentPassRequest * passrequest = [[PKAddPaymentPassRequest alloc] init];
    passrequest.encryptedPassData = @"";
    passrequest.activationData = @"";
    passrequest.ephemeralPublicKey =@"";
    
}

-(void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
         didFinishAddingPaymentPass:(PKPaymentPass *)pass
                              error:(NSError *)error{
    if(pass == nil){
        NSLog(@"Error: %@",error.localizedDescription);
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end