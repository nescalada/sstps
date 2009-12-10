
public class Cliente {
  private double time;
  private final double r_prob = 0.8;
  private final double fail_oft_prob = 0.02;
  private final double do_psf_prob = 0.17;
  private final double fail_psf_prob = 0.02;
  private boolean r, fail_oft, do_psf, fail_psf, paid;

  public Cliente(double time) {
    super();
    this.time = time;
    this.r = generateR(); //true=se queda en el sistema | false=se va
    this.fail_oft = false; //true=falla oft | false=no falla oft
    this.do_psf = generateDoPsf(); //true=hace psf | false=no hace psf
    this.fail_psf = false; //true=falla psf | false=no falla psf
    this.paid = false; //true=pago en c1,c2 o c3 | false=no pago en c1,c2 o c3
  }

  public void Pay(){
    this.paid = true;
  }

  public boolean generateFailPsf() {
    Statistics s = new Statistics();
    double resp = s.uniform(0, 1);
    
    if(resp <= fail_psf_prob){
      return true;
    }
    return false;
  }

  public boolean generateFailOft() {
    Statistics s = new Statistics();
    double resp = s.uniform(0, 1);
    
    if(resp <= fail_oft_prob){
      return true;
    }
    return false;
  }

  private boolean generateDoPsf() {
    Statistics s = new Statistics();
    double resp = s.uniform(0, 1);
    
    if(resp <= do_psf_prob){
      return true;
    }
    return false;
  }

  private boolean generateR() {
    Statistics s = new Statistics();
    double resp = s.uniform(0, 1);
    
    if(resp <= r_prob){
      return true;
    }
    return false;
  }

  public double getTime() {
    return time;
  }

  public boolean isR() {
    return r;
  }

  public boolean isFail_oft() {
    return fail_oft;
  }

  public boolean isDo_psf() {
    return do_psf;
  }

  public boolean isFail_psf() {
    return fail_psf;
  }

  public boolean isPaid() {
    return paid;
  }
}
