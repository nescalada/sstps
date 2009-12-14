
public class Cliente {
  private double time, form_time, time_receive_form;
  private final double r_prob = 0.8;
  private final double fail_oft_prob = 0.02;
  private final double do_psf_prob = 0.17;
  private final double fail_psf_prob = 0.02;
  private boolean r, fail_oft, do_psf, fail_psf, paid;
  private int id;

  public Cliente(double time, int id) {
    super();
    this.id = id;
    this.time = time;
    this.time_receive_form = 0;
    this.r = generateR(); //true=se queda en el sistema | false=se va
    this.fail_oft = false; //true=falla oft | false=no falla oft
    this.do_psf = generateDoPsf(); //true=hace psf | false=no hace psf
    this.fail_psf = false; //true=falla psf | false=no falla psf
    this.paid = false; //true=pago en c1,c2 o c3 | false=no pago en c1,c2 o c3
    Statistics s = new Statistics();
    this.form_time = s.uniform(0.5, 2.0);//tiempo que tarda en llenar el formulario
    //Distribucion uniforme entre 2 y 4
  }

  public void Pay(){
    this.paid = true;
  }

  public int getId(){
    return this.id;
  }
  
  public String toString(){
   return "{"+this.id+", rc:"+ this.time_receive_form+ ",fin: " +this.getTimeFinishForm()+ "}";
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

  public double getFormTime(){
    return this.form_time;
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

  public double getTime_receive_form() {
    return time_receive_form;
  }

  public void setTime_receive_form(double time_last_stage) {
    this.time_receive_form = time_last_stage;
  }

  public void setFail_oft() {
    this.fail_oft = generateFailOft();
  }

  public void setFail_psf() {
    this.fail_psf = generateFailPsf();
    
  }
  
  public double getTimeFinishForm(){
    return this.time_receive_form+this.form_time;
  }
}
