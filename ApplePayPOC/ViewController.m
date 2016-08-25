//
//  ViewController.m
//  ApplePayPOC
//
//  Created by Ramirez, Antonio on 8/23/16.
//  Copyright © 2016 Ramirez, Antonio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

- (IBAction)initProvisioning:(id)sender {
    
    PKAddPaymentPassRequestConfiguration * passDetails = [[PKAddPaymentPassRequestConfiguration alloc] initWithEncryptionScheme:PKEncryptionSchemeECC_V2];
    passDetails.cardholderName = @"";
    passDetails.primaryAccountSuffix = @"";
    passDetails.localizedDescription = @"";
    passDetails.primaryAccountIdentifier = @"";
    passDetails.paymentNetwork = @"";
    
    PKAddPaymentPassViewController * passViewController = [[PKAddPaymentPassViewController alloc] initWithRequestConfiguration:passDetails delegate:self];
    [self.navigationController pushViewController:passViewController animated:NO];
}

-(void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
generateRequestWithCertificateChain:(NSArray<NSData *> *)certificates
                              nonce:(NSData *)nonce
                     nonceSignature:(NSData *)nonceSignature
                  completionHandler:(void (^)(PKAddPaymentPassRequest * _Nonnull))handler{
    
    NSArray * certs = certificates; //Certificates
    NSData * n = nonce; // Nonce
    NSData * nSignature = nonceSignature; //Nonce Signature
}

-(void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
         didFinishAddingPaymentPass:(PKPaymentPass *)pass
                              error:(NSError *)error{
    
}

@end