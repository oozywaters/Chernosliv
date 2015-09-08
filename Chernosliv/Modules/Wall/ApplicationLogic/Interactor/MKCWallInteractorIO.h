//
//  MKCWallInteractorIO.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

//@class ANCategoryDomainModel;

@protocol MKCWallInteractorInput <NSObject>

- (void)loadPosts;

//- (void)loadCategoriesList;
//- (void)removeCategory:(ANCategoryDomainModel*)model;
//- (void)addCategory:(ANCategoryDomainModel*)model;

@end


@protocol MKCWallInteractorOutput <NSObject>

- (void)pageLoadedWithPosts:(NSArray *)posts;

//- (void)categoriesListLoaded:(NSArray*)categories;
//- (void)categoryRemovedSuccessfully:(ANCategoryDomainModel*)category;

@end