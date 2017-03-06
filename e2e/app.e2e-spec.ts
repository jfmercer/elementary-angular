import { ElementaryAngularPage } from './app.po';

describe('elementary-angular App', () => {
  let page: ElementaryAngularPage;

  beforeEach(() => {
    page = new ElementaryAngularPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
