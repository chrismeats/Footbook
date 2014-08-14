//
//  DetailViewController.m
//  Footbook
//
//  Created by ETC ComputerLand on 8/13/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "DetailViewController.h"
#import "PostCommentViewController.h"

@interface DetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *shoeSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *hairinessLabel;
@property (strong, nonatomic) IBOutlet UILabel *smellinessLabel;
@property (strong, nonatomic) IBOutlet UILabel *feetLabel;
@property (strong, nonatomic) IBOutlet UIImageView *footImage;

@property UIImagePickerController *picker;
@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

    self.title = self.profile.name;
    self.shoeSizeLabel.text = self.profile.shoeSize;
    self.hairinessLabel.text = self.profile.hairiness;
    self.smellinessLabel.text = self.profile.smelliness;
    self.feetLabel.text = self.profile.feet;

    if (self.profile.photo) {
        self.footImage.image = [UIImage imageWithData:self.profile.photo];
    }

}

- (IBAction)onAddPhoto:(UIButton *)sender
{
//    [self presentViewController:self.picker animated:YES completion:^{
//        <#code#>
//    }];
    [self presentViewController:self.picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.footImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.profile.photo = UIImagePNGRepresentation(self.footImage.image);
    [self.profile.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)unwindFromPostComment:(UIStoryboardSegue *)sender
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PostCommentViewController *dvc = segue.destinationViewController;
    dvc.profile = self.profile;
}


@end
