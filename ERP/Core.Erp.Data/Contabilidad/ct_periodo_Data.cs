using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Contabilidad
{
    public class ct_periodo_Data
    {
        public List<ct_periodo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {

            try
            {

                List<ct_periodo_Info> Lista;

                Entities_general Context_g = new Entities_general();
                Entities_contabilidad Context = new Entities_contabilidad();
                    var lst_mes = (from q in Context_g.tb_mes
                                  select new tb_mes_Info
                                  {
                                      idMes = q.idMes,
                                      smes = q.smes
                                  }).ToList();
                Context_g.Dispose();

                var lst_periodo = (from q in Context.ct_periodo
                                   where q.IdEmpresa == IdEmpresa
                                   select new ct_periodo_Info
                                   {
                                       IdPeriodo = q.IdPeriodo,
                                       IdEmpresa = q.IdEmpresa,
                                       IdanioFiscal = q.IdanioFiscal,
                                       pe_FechaIni = q.pe_FechaIni,
                                       pe_FechaFin = q.pe_FechaFin,
                                       pe_mes = q.pe_mes,
                                       pe_cerrado = q.pe_cerrado,
                                       pe_estado = q.pe_estado,
                                   }).ToList();                


                if (mostrar_anulados == true)
                        Lista = (from q in lst_periodo
                                 join m in lst_mes
                                 on q.pe_mes equals m.idMes
                                 where q.IdEmpresa == IdEmpresa
                                 select new ct_periodo_Info
                                 {
                                     IdPeriodo = q.IdPeriodo,
                                     IdEmpresa = q.IdEmpresa,
                                     IdanioFiscal = q.IdanioFiscal,
                                     pe_FechaIni = q.pe_FechaIni,
                                     pe_FechaFin = q.pe_FechaFin,
                                     pe_mes = q.pe_mes,
                                     pe_cerrado = q.pe_cerrado,
                                     pe_estado = q.pe_estado,
                                     smes = m.smes
                                 }).ToList();
                    else
                        Lista = (from q in lst_periodo
                                 join m in lst_mes
                                  on q.pe_mes equals m.idMes
                                 where q.IdEmpresa == IdEmpresa
                                  && q.pe_estado == "A"
                                  select new ct_periodo_Info
                                  {
                                      IdPeriodo = q.IdPeriodo,
                                      IdEmpresa = q.IdEmpresa,
                                      IdanioFiscal = q.IdanioFiscal,
                                      pe_FechaIni = q.pe_FechaIni,
                                      pe_FechaFin = q.pe_FechaFin,
                                      pe_mes = q.pe_mes,
                                      pe_cerrado = q.pe_cerrado,
                                      pe_estado = q.pe_estado,
                                      smes = m.smes
                                  }).ToList();
                
                Lista.ForEach(q => q.nom_periodo_combo = q.IdanioFiscal + " "+ q.smes);
                
                Context.Dispose();
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ct_periodo_Info get_info(int IdEmpresa, int IdPeriodo)
        {
            try
            {
                ct_periodo_Info info = new ct_periodo_Info();

                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    ct_periodo Entity = Context.ct_periodo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdPeriodo == IdPeriodo);
                    if (Entity == null) return null;
                    info = new ct_periodo_Info
                    {
                        IdPeriodo = Entity.IdPeriodo,
                        IdEmpresa = Entity.IdEmpresa,
                        IdanioFiscal = Entity.IdanioFiscal,
                        pe_FechaIni = Entity.pe_FechaIni,
                        pe_FechaFin = Entity.pe_FechaFin,
                        pe_mes = Entity.pe_mes,
                        pe_cerrado_bool = Entity.pe_cerrado == "S" ? true : false,
                        pe_estado = Entity.pe_estado
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ct_periodo_Info info)
        {
            try
            {
                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    ct_periodo Entity = new ct_periodo
                    {
                        IdPeriodo = info.IdPeriodo = get_id(info.IdEmpresa),
                        IdEmpresa = info.IdEmpresa,
                        IdanioFiscal = info.IdanioFiscal,
                        pe_FechaIni = info.pe_FechaIni.Date,
                        pe_FechaFin = info.pe_FechaFin.Date,
                        pe_mes = info.pe_mes,
                        pe_cerrado = info.pe_cerrado_bool == true ? "S" : "N",
                        pe_estado = info.pe_estado="A"
                    };
                    Context.ct_periodo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool modificarDB(ct_periodo_Info info)
        {
            try
            {
                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    ct_periodo Entity = Context.ct_periodo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdPeriodo == info.IdPeriodo);
                    if (Entity == null)
                        return false;
                    Entity.IdPeriodo = info.IdPeriodo;
                    Entity.pe_mes = info.pe_mes;
                    Entity.pe_FechaFin = info.pe_FechaFin.Date;
                    Entity.pe_FechaIni = info.pe_FechaIni.Date;
                    Entity.pe_cerrado = info.pe_cerrado_bool == true ? "S" : "N";
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ct_periodo_Info info)
        {
            try
            {
                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    ct_periodo Entity = Context.ct_periodo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdPeriodo == info.IdPeriodo);
                    if (Entity == null)
                        return false;
                    Entity.pe_estado = info.pe_estado = "I";

                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;
                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    var lst = from q in Context.ct_periodo
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdPeriodo) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
